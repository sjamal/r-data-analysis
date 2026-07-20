# Statistical Analysis: SVM Tuning and Testing

This folder currently contains one complete classification workflow used in master's research and now adapted for safe, reproducible sharing.

## Included Files

- `svm_tuning_and_testing.R`: Main script for train/test split, linear SVM training, hyperparameter tuning, and ROC analysis.
- `sample-data/svm_category1_sample.csv`: Clean synthetic sample dataset.
- `sample-data/svm_category1_sample_noisy.csv`: Synthetic sample with additional overlap/noise.
- `RUNBOOK.md`: Operational steps, troubleshooting, and expected outputs.
- `output/`: Generated text report.
- `images/`: Generated figures.

## Why Synthetic Data

The original research files are not committed because they contained sensitive content. The synthetic samples keep the same broad shape and binary classification intent so the script can be executed and tested.

## Input Schema

The script expects a CSV with:

- One target column named `class`.
- Binary values in `class` (for example `0` and `1`).
- Remaining columns as numeric features.

## Run

From repository root:

```bash
Rscript scripts/statistical-analysis/svm_tuning_and_testing.R
```

Run with an explicit input file:

```bash
Rscript scripts/statistical-analysis/svm_tuning_and_testing.R \
  scripts/statistical-analysis/sample-data/svm_category1_sample_noisy.csv
```

## Outputs

- `output/svm_tuning_and_testing_report.txt`
- `images/svm_roc_curve.jpg`
- `images/svm_tuning_grid.jpg`

## Required Packages

```r
install.packages(c("e1071", "caret", "ROCR"))
```

## Reproducibility Notes

- Script sets a random seed for deterministic splitting.
- Paths are relative to the script location, not machine-specific directories.
- Metrics include accuracy, precision, recall, F1, and AUC.
