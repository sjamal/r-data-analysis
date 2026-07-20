# R Data Analysis

Production-grade R libraries and scripts for statistical analysis, data visualization, machine learning, and exploratory data analysis. Designed for data scientists, analysts, and researchers.

## Features

- **Statistical Analysis** — Hypothesis testing, SVM tuning, ROC analysis, and model validation
- **Data Visualization** — Multi-dimensional plotting, interactive dashboards, publication-ready graphics
- **Data Processing** — Transformation, aggregation, and preparation pipelines
- **Machine Learning** — Supervised learning with hyperparameter optimization
- **Utilities** — Helper functions for common data science tasks

## Modules

### 📊 Statistical Analysis

Comprehensive machine learning and statistical testing framework.

- **[`statistical-analysis/`](statistical-analysis/README.md)** — Complete documentation
  - `svm_tuning_and_testing.R` — Support Vector Machine hyperparameter optimization
  - `RUNBOOK.md` — Step-by-step usage guide
  - Sample data and generated reports

#### Use Cases
- Binary and multi-class classification
- Hyperparameter tuning and cross-validation
- ROC curve analysis and AUC scoring
- Model performance reporting

#### Example
```R
source('statistical-analysis/svm_tuning_and_testing.R')
# Automatically handles:
# - Data loading from CSV
# - Train/test split
# - Grid search over SVM parameters (C, gamma, kernel)
# - Cross-validation
# - ROC curve generation
# - Performance metrics output
```

### 📈 Data Visualization

Tools for creating publication-ready visualizations from complex datasets.

- **[`visualization/`](visualization/README.md)** — Complete documentation
  - Multi-dimensional plotting functions
  - Publication-quality graphics
  - Interactive dashboard components
  - Color schemes and styling utilities

#### Use Cases
- Exploratory data analysis (EDA)
- Publication figures
- Interactive dashboards
- Comparative analysis plots

### 🔄 Data Processing

Data transformation and preparation utilities.

- **[`data-processing/`](data-processing/README.md)** — Complete documentation
  - Aggregation pipelines
  - Missing value handling
  - Feature engineering
  - Format conversion

#### Use Cases
- ETL workflows
- Data quality checks
- Feature preparation for ML
- Data standardization

### 🔍 Exploratory Data Analysis

Tools for rapid data exploration and insight generation.

- **[`data-analysis/`](data-analysis/README.md)** — Complete documentation
  - Summary statistics
  - Correlation analysis
  - Outlier detection
  - Distribution analysis

### 🛠 Utilities

Reusable helper functions and convenience wrappers.

- **[`utilities/`](utilities/README.md)** — Complete documentation
  - Common data science functions
  - Performance optimization
  - Logging and reporting
  - Error handling

## Installation

### Requirements

- R 3.6.0+ (4.0+ recommended)
- Required packages (automatically installed on first run):
  - `caret` — machine learning framework
  - `ggplot2` — visualization
  - `dplyr` — data manipulation
  - `tidyr` — data tidying
  - `pROC` — ROC curve analysis
  - `e1071` — SVM and other ML algorithms

### Setup

```bash
git clone https://github.com/sjamal/r-data-analysis.git
cd r-data-analysis
```

Then in R:
```R
# Install dependencies
install.packages(c('caret', 'ggplot2', 'dplyr', 'tidyr', 'pROC', 'e1071'))

# Source utilities
source('utilities/install_and_load.R')
```

## Quick Start

### Basic SVM Classification

```R
# Load and run SVM tuning
source('statistical-analysis/svm_tuning_and_testing.R')

# Input: CSV with features and target
# Output: 
#   - ROC curves (PNG)
#   - Performance metrics (TXT)
#   - Tuning grid results (CSV)
```

### Explore a Dataset

```R
source('utilities/load_and_summarize.R')

# Automatic exploration:
# - Summary statistics
# - Data types and missing values
# - Correlation matrix
# - Distribution plots
data_summary <- load_and_summarize('your_data.csv')
```

### Create Publication-Ready Plots

```R
source('visualization/plotting_utils.R')

plot_comparison <- function(df, x_var, y_var, group_var) {
  ggplot(df, aes_string(x = x_var, y = y_var, color = group_var)) +
    geom_point(size = 3) +
    theme_publication() +
    labs(title = 'Comparative Analysis',
         x = x_var, y = y_var)
}

ggsave('comparison.pdf', width = 10, height = 6)
```

## Project Structure

```
.
├── README.md                           # This file
├── LICENSE                             # License information
├── statistical-analysis/               # ML and statistical testing
│   ├── README.md
│   ├── RUNBOOK.md                      # Step-by-step guide
│   ├── svm_tuning_and_testing.R       # SVM classification pipeline
│   ├── sample-data/                   # Example datasets
│   ├── output/                        # Generated reports
│   └── images/                        # Generated plots
├── visualization/                      # Plotting and graphics
│   ├── README.md
│   └── plotting_utils.R               # Reusable plot functions
├── data-processing/                    # Data transformation
│   ├── README.md
│   └── transform_pipeline.R           # ETL functions
├── data-analysis/                      # Exploratory analysis
│   ├── README.md
│   └── eda_functions.R                # EDA utilities
└── utilities/                          # Helper functions
    ├── README.md
    ├── install_and_load.R             # Dependency management
    └── common_functions.R             # General utilities
```

## Workflows

### Complete Classification Pipeline

```R
# 1. Load dependencies
source('utilities/install_and_load.R')
source('data-processing/transform_pipeline.R')

# 2. Prepare data
raw_data <- read.csv('data.csv')
clean_data <- clean_and_transform(raw_data)

# 3. Explore
source('data-analysis/eda_functions.R')
explore_data(clean_data)

# 4. Model and tune
source('statistical-analysis/svm_tuning_and_testing.R')
results <- run_svm_tuning(clean_data, target_col = 'label')

# 5. Visualize
source('visualization/plotting_utils.R')
plot_roc(results$roc_curve)
```

### Batch Analysis

```bash
# Run analysis on multiple datasets
for dataset in data/*.csv; do
  Rscript analyze_dataset.R "$dataset"
done
```

## Output Formats

Scripts generate output in multiple formats for different use cases:

- **PNG** — High-resolution plots for presentations
- **PDF** — Publication-ready figures
- **CSV** — Data export for downstream tools
- **RData** — R-native format for reproducibility
- **HTML** — Interactive reports and dashboards

## Best Practices

### Code Organization

1. **Separate analysis from utilities** — Keep reusable functions in utilities/
2. **Use consistent naming** — Function names and variable names follow conventions
3. **Document assumptions** — Include comments about data requirements
4. **Version your data** — Keep baseline datasets for reproducibility

### Performance

- Use `data.table` for large datasets (>1GB)
- Parallelize cross-validation with `doParallel`
- Profile with `profvis` for optimization

### Reproducibility

- Set seed for RNG: `set.seed(12345)`
- Document package versions: `sessionInfo()`
- Include sample data in repo
- Create RMarkdown notebooks for reports

## Advanced Features

### Automated Reporting

```R
# Generate HTML report with all analysis
rmarkdown::render('analysis_template.Rmd',
  output_format = 'html_document',
  params = list(data = 'my_data.csv'))
```

### Parallel Processing

```R
# Speed up cross-validation with multiple cores
library(doParallel)
registerDoParallel(cores = 4)

train(model ~ ., 
      data = training_data,
      trControl = trainControl(allowParallel = TRUE))
```

### Interactive Shiny Apps

```R
# Create interactive dashboards
source('visualization/shiny_app.R')
shinyApp(ui, server)
```

## Contributing

Contributions welcome! When adding scripts:

- Include documentation in script headers
- Add examples in README for your category
- Test with sample data
- Follow R code style conventions (see [tidyverse style guide](https://style.tidyverse.org/))
- Update relevant README sections

## Related Projects

- [python-sysadmin-tools](https://github.com/sjamal/python-sysadmin-tools) — Python data utilities
- [bash](https://github.com/sjamal/bash) — Bash scripts for data processing pipelines
- [opencampus-ai-framework](https://github.com/sjamal/opencampus-ai-framework) — AI/ML orchestration framework

## License

See [LICENSE](LICENSE) file.

## Questions?

- Review category-specific READMEs in each subdirectory
- Check script headers for detailed documentation
- Review sample data and generated reports
- Open an issue with your use case

## Citation

If you use these tools in research or publications, please cite:

```bibtex
@software{sjamal_ranalysis_2024,
  title={R Data Analysis Tools},
  author={Jamal, S.},
  year={2024},
  url={https://github.com/sjamal/r-data-analysis}
}
```
