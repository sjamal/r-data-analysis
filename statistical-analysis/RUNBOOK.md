# Runbook: SVM Tuning and Testing

## Purpose

Run and validate the SVM classification workflow in a reproducible way without sensitive source data.

## Preconditions

- R 4.2 or later
- Packages installed:

```r
install.packages(c("e1071", "caret", "ROCR"))
```

## Inputs

Default synthetic input:

- `sample-data/svm_category1_sample.csv`

Alternative synthetic input:

- `sample-data/svm_category1_sample_noisy.csv`

Input requirements:

- CSV format
- Binary target column named `class`
- Remaining columns numeric

## Run Steps

From repository root:

```bash
Rscript scripts/statistical-analysis/svm_tuning_and_testing.R
```

Run with explicit input:

```bash
Rscript scripts/statistical-analysis/svm_tuning_and_testing.R \
  scripts/statistical-analysis/sample-data/svm_category1_sample_noisy.csv
```

## Expected Artifacts

- `output/svm_tuning_and_testing_report.txt`
- `images/svm_roc_curve.jpg`
- `images/svm_tuning_grid.jpg`

## Validation Checklist

- Script exits without errors.
- Report file contains confusion matrix and metrics.
- ROC and tuning images are created and non-empty.
- Best tuning parameters are listed in report.

## Troubleshooting

- Error: missing packages
  - Install required packages and rerun.
- Error: class column missing
  - Ensure the CSV contains a column named `class`.
- Error: non-binary target
  - Ensure exactly two values in `class`.
- ROC or tuning plot not created
  - Confirm write permission in `images/`.
