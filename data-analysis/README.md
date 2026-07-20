# Data Analysis Scripts

Scripts for exploratory data analysis (EDA), data profiling, and statistical insights.

## Purpose

Data analysis scripts focus on:
- Exploratory data analysis (EDA)
- Data profiling and summary statistics
- Pattern identification
- Data quality assessment
- Initial insights and hypotheses

## Common Tasks

### Loading and Exploring Data
```r
library(tidyverse)
df <- read.csv("data.csv")
head(df)
summary(df)
str(df)
```

### Quick EDA Functions
```r
# Summary statistics
summary(df)

# Data structure
str(df)

# Missing values
colSums(is.na(df))

# Basic correlations
cor(df[, sapply(df, is.numeric)])
```

## Recommended Packages

- **tidyverse**: Data manipulation pipeline
- **dplyr**: Fast data wrangling
- **data.table**: Large dataset handling
- **summarytools**: Quick summary statistics
- **skimr**: Enhanced data summaries
- **DataExplorer**: Automated EDA

## Example Structure

```r
################################################################################
# Script: analyze_sales_data.R
# Purpose: Exploratory analysis of sales dataset
# Author: Your Name
################################################################################

# Load libraries
library(tidyverse)
library(dplyr)

# Load data
df <- read.csv("data/sales.csv")

# Basic exploration
head(df)
summary(df)

# Analysis
results <- df %>%
  group_by(region) %>%
  summarise(total_sales = sum(amount),
            avg_transaction = mean(amount),
            n_transactions = n())

print(results)
```

## Tips

- Always check data types and missing values first
- Document assumptions and findings
- Save plots and summary tables for reports
- Use version control for reproducibility

## File Naming

Use descriptive names:
- `analyze_*.R` for exploratory scripts
- `profile_*.R` for data profiling
- `eda_*.R` for full EDA workflows
