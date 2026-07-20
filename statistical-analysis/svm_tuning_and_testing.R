################################################################################
# Script: svm_tuning_and_testing.R
# Purpose: Train, evaluate, and tune a linear SVM classifier for binary labels.
#
# Notes:
# - This script is a professionalized and reproducible version of a master's
#   research workflow where original sensitive inputs are unavailable.
# - It supports synthetic sample inputs shipped with this repository.
#
# Adapted from ideas in:
# http://www.cs.upc.edu/~belanche/Docencia/mineria/English-september-2008/
# Practical-work/Labo-SVMs.R
#
# Usage examples:
#   Rscript scripts/statistical-analysis/svm_tuning_and_testing.R
#   Rscript scripts/statistical-analysis/svm_tuning_and_testing.R \
#     scripts/statistical-analysis/sample-data/svm_category1_sample_noisy.csv
################################################################################

required_packages <- c("e1071", "caret", "ROCR")

missing_packages <- required_packages[!vapply(
	required_packages,
	requireNamespace,
	quietly = TRUE,
	FUN.VALUE = logical(1)
)]

if (length(missing_packages) > 0) {
	stop(
		paste(
			"Missing required package(s):",
			paste(missing_packages, collapse = ", "),
			"\nInstall with: install.packages(c(",
			paste(sprintf("\"%s\"", missing_packages), collapse = ", "),
			"))"
		),
		call. = FALSE
	)
}

suppressPackageStartupMessages({
	library(e1071)
	library(caret)
	library(ROCR)
})

get_script_dir <- function() {
	script_args <- commandArgs(trailingOnly = FALSE)
	file_arg <- grep("^--file=", script_args, value = TRUE)

	if (length(file_arg) > 0) {
		return(dirname(normalizePath(sub("^--file=", "", file_arg[1]))))
	}

	normalizePath(getwd())
}

ensure_dir <- function(path) {
	if (!dir.exists(path)) {
		dir.create(path, recursive = TRUE, showWarnings = FALSE)
	}
}

safe_divide <- function(numerator, denominator) {
	if (is.na(denominator) || denominator == 0) {
		return(NA_real_)
	}
	numerator / denominator
}

compute_binary_metrics <- function(confusion_table, positive_label) {
	classes <- rownames(confusion_table)
	negative_label <- setdiff(classes, positive_label)

	if (length(negative_label) != 1) {
		stop("Expected exactly two classes for binary metrics.")
	}

	tp <- confusion_table[positive_label, positive_label]
	tn <- confusion_table[negative_label, negative_label]
	fp <- confusion_table[positive_label, negative_label]
	fn <- confusion_table[negative_label, positive_label]

	precision <- safe_divide(tp, tp + fp)
	recall <- safe_divide(tp, tp + fn)
	f1 <- safe_divide(2 * precision * recall, precision + recall)

	list(
		accuracy = safe_divide(tp + tn, sum(confusion_table)),
		precision = precision,
		recall = recall,
		f1 = f1
	)
}

run_experiment <- function(input_csv, output_dir, image_dir, seed = 42) {
	set.seed(seed)

	ensure_dir(output_dir)
	ensure_dir(image_dir)

	if (!file.exists(input_csv)) {
		stop(paste("Input file not found:", input_csv), call. = FALSE)
	}

	dataset <- read.csv(input_csv, stringsAsFactors = FALSE)

	if (!("class" %in% names(dataset))) {
		stop("Input data must include a 'class' column.", call. = FALSE)
	}

	dataset$class <- as.factor(dataset$class)
	if (nlevels(dataset$class) != 2) {
		stop("The 'class' column must contain exactly two classes.", call. = FALSE)
	}

	positive_label <- levels(dataset$class)[2]

	split_index <- caret::createDataPartition(dataset$class, p = 0.8, list = FALSE)
	train_data <- dataset[split_index, , drop = FALSE]
	test_data <- dataset[-split_index, , drop = FALSE]

	if (nrow(test_data) == 0) {
		stop("Test split is empty; provide more rows in the input file.", call. = FALSE)
	}

	model_start <- Sys.time()
	svm_model <- e1071::svm(
		class ~ .,
		data = train_data,
		type = "C-classification",
		kernel = "linear",
		cost = 100,
		gamma = 1,
		cross = 10,
		probability = TRUE
	)
	model_end <- Sys.time()

	pred_start <- Sys.time()
	svm_pred <- predict(
		svm_model,
		newdata = test_data[, setdiff(names(test_data), "class"), drop = FALSE],
		decision.values = TRUE,
		probability = TRUE
	)
	pred_end <- Sys.time()

	confusion_tbl <- table(pred = svm_pred, true = test_data$class)
	cm <- caret::confusionMatrix(confusion_tbl, positive = positive_label)
	metrics <- compute_binary_metrics(confusion_tbl, positive_label)

	tune_start <- Sys.time()
	tuned_svm <- e1071::tune.svm(
		class ~ .,
		data = train_data,
		gamma = 2^(-2:2),
		cost = 2^(2:6)
	)
	tune_end <- Sys.time()

	prob_matrix <- attr(svm_pred, "probabilities")
	if (!is.null(prob_matrix) && (positive_label %in% colnames(prob_matrix))) {
		roc_input <- prob_matrix[, positive_label]
	} else {
		roc_input <- as.numeric(attr(svm_pred, "decision.values"))
	}

	roc_pred <- ROCR::prediction(roc_input, test_data$class)
	roc_perf <- ROCR::performance(roc_pred, "tpr", "fpr")
	auc_perf <- ROCR::performance(roc_pred, "auc")
	auc_value <- as.numeric(auc_perf@y.values[[1]])

	roc_image <- file.path(image_dir, "svm_roc_curve.jpg")
	jpeg(roc_image)
	plot(
		roc_perf,
		main = "ROC Curve - Linear SVM",
		sub = "Synthetic Category 1-like data",
		colorize = TRUE,
		lwd = 2
	)
	dev.off()

	tune_image <- file.path(image_dir, "svm_tuning_grid.jpg")
	jpeg(tune_image)
	plot(
		tuned_svm,
		transform.x = log10,
		xlab = expression(log[10](gamma)),
		ylab = "Cost (C)",
		main = "10-fold CV Linear SVM Tuning"
	)
	dev.off()

	report_file <- file.path(output_dir, "svm_tuning_and_testing_report.txt")
	report_lines <- c(
		"SVM Tuning and Testing Report",
		"================================",
		paste("Input file:", input_csv),
		paste("Rows:", nrow(dataset)),
		paste("Columns:", ncol(dataset)),
		paste("Positive class:", positive_label),
		"",
		"Confusion Matrix:",
		paste(capture.output(print(confusion_tbl)), collapse = "\n"),
		"",
		paste("Accuracy:", round(metrics$accuracy, 4)),
		paste("Precision:", round(metrics$precision, 4)),
		paste("Recall:", round(metrics$recall, 4)),
		paste("F1 Score:", round(metrics$f1, 4)),
		paste("AUC:", round(auc_value, 4)),
		"",
		paste(
			"Model training time:",
			round(as.numeric(difftime(model_end, model_start, units = "secs")), 3),
			"seconds"
		),
		paste(
			"Prediction time:",
			round(as.numeric(difftime(pred_end, pred_start, units = "secs")), 3),
			"seconds"
		),
		paste(
			"Hyperparameter tuning time:",
			round(as.numeric(difftime(tune_end, tune_start, units = "secs")), 3),
			"seconds"
		),
		"",
		"Caret confusion matrix summary:",
		paste(capture.output(print(cm)), collapse = "\n"),
		"",
		"Best tuning parameters:",
		paste(capture.output(print(tuned_svm$best.parameters)), collapse = "\n")
	)

	writeLines(report_lines, con = report_file)

	cat("Analysis complete.\n")
	cat("Report:", report_file, "\n")
	cat("ROC image:", roc_image, "\n")
	cat("Tuning image:", tune_image, "\n")

	invisible(
		list(
			report = report_file,
			roc_image = roc_image,
			tune_image = tune_image,
			metrics = metrics,
			auc = auc_value,
			best_parameters = tuned_svm$best.parameters
		)
	)
}

script_dir <- get_script_dir()
args <- commandArgs(trailingOnly = TRUE)

default_input <- file.path(script_dir, "sample-data", "svm_category1_sample.csv")
input_csv <- if (length(args) >= 1) args[[1]] else default_input
output_dir <- file.path(script_dir, "output")
image_dir <- file.path(script_dir, "images")

run_experiment(input_csv = input_csv, output_dir = output_dir, image_dir = image_dir)

