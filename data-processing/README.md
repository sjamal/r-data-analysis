# Data Processing & Cleaning Scripts

Scripts for data transformation, cleaning, normalization, and text processing (including TF-IDF analysis).

## Purpose

Data processing scripts focus on:
- Data cleaning and validation
- Missing value handling
- Data transformation and normalization
- Text processing and NLP
- TF-IDF (Term Frequency-Inverse Document Frequency) analysis
- Feature engineering
- Data integration and merging

## Common Data Cleaning Tasks

### Handling Missing Values
```r
library(tidyverse)

# Check missing values
colSums(is.na(df))

# Remove rows with missing values
df_clean <- df %>% drop_na()

# Fill missing values
df_filled <- df %>%
  mutate(across(everything(), ~replace_na(., 0)))

# Forward fill
df_filled <- df %>%
  fill(column_name, .direction = "down")
```

### Data Normalization
```r
# Min-max scaling
df_scaled <- df %>%
  mutate(across(where(is.numeric),
                ~(. - min(., na.rm = TRUE)) / 
                  (max(., na.rm = TRUE) - min(., na.rm = TRUE))))

# Z-score standardization
df_standard <- df %>%
  mutate(across(where(is.numeric),
                ~scale(.) %>% as.numeric()))
```

### Text Processing
```r
library(tidytext)
library(stringr)

# Convert to lowercase
df$text <- tolower(df$text)

# Remove punctuation
df$text <- str_remove_all(df$text, "[[:punct:]]")

# Tokenization
tokens <- df %>%
  unnest_tokens(word, text)
```

## TF-IDF Analysis

TF-IDF measures the importance of words in a document corpus.

### Basic TF-IDF
```r
library(tidytext)

# Prepare text data
tf_idf_data <- df %>%
  unnest_tokens(word, text) %>%
  count(document, word) %>%
  bind_tf_idf(word, document, n)

# View top words by TF-IDF
tf_idf_data %>%
  arrange(desc(tf_idf)) %>%
  head(20)
```

### TF-IDF with Vectorization
```r
library(quanteda)

# Create document-feature matrix
dfm <- tokens(df$text) %>%
  dfm() %>%
  dfm_tfidf()

head(dfm)
```

## Recommended Packages

- **dplyr**: Data manipulation
- **tidyr**: Data reshaping
- **stringr**: String manipulation
- **tidytext**: Text mining and NLP
- **quanteda**: Text analysis and NLP
- **tm**: Text mining framework
- **data.table**: Fast data manipulation
- **caret**: Feature engineering

## Data Quality Checks

```r
# Check data types
str(df)

# Look for duplicates
df %>%
  add_count(id) %>%
  filter(n > 1)

# Identify outliers
df %>%
  filter(value > mean(value, na.rm = TRUE) + 3*sd(value, na.rm = TRUE))

# Validate ranges
df %>%
  filter(age < 0 | age > 150)
```

## Example Structure

```r
################################################################################
# Script: clean_customer_data.R
# Purpose: Data cleaning and preprocessing of customer dataset
# Author: Your Name
################################################################################

library(tidyverse)
library(janitor)

# Load raw data
df_raw <- read.csv("data/raw/customers.csv")

# Initial inspection
head(df_raw)
colSums(is.na(df_raw))

# Cleaning pipeline
df_clean <- df_raw %>%
  # Standardize column names
  clean_names() %>%
  # Remove duplicate rows
  distinct() %>%
  # Handle missing values
  drop_na(customer_id) %>%
  # Data type conversions
  mutate(signup_date = as.Date(signup_date),
         age = as.numeric(age)) %>%
  # Remove outliers
  filter(age > 0, age < 120) %>%
  # Normalize text fields
  mutate(across(where(is.character), tolower))

# Save cleaned data
write.csv(df_clean, "data/processed/customers_clean.csv", row.names = FALSE)

cat("Data cleaning complete. \n")
cat("Rows removed:", nrow(df_raw) - nrow(df_clean), "\n")
```

## File Naming

Use descriptive names:
- `clean_*.R` for data cleaning scripts
- `process_*.R` for data transformation
- `tfidf_*.R` for text/TF-IDF analysis
- `preprocess_*.R` for general preprocessing
