# Utility Scripts

Helper functions, reusable code templates, and common utility scripts.

## Purpose

Utility scripts provide:
- Reusable functions for common tasks
- Helper functions to support other scripts
- Custom themes and styling functions
- Data I/O utilities
- Custom plotting functions
- Validation and error handling

## Common Utilities

### Custom Functions Template
```r
# File: custom_functions.R

# Function template with documentation
#' Calculate standard error
#'
#' @param x Numeric vector
#' @return Standard error of x
#' @examples
#' se(c(1, 2, 3, 4, 5))
se <- function(x) {
  sqrt(var(x) / length(x))
}
```

### Custom ggplot2 Theme
```r
# File: custom_theme.R

theme_custom <- function() {
  theme_minimal() +
  theme(
    text = element_text(family = "sans", color = "#333333"),
    plot.title = element_text(face = "bold", size = 14, margin = margin(b = 10)),
    plot.subtitle = element_text(size = 12, margin = margin(b = 10)),
    axis.title = element_text(size = 11),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#e0e0e0")
  )
}
```

### Data I/O Utilities
```r
# File: io_utilities.R

# Safe CSV reading with error handling
read_safe <- function(file) {
  tryCatch({
    df <- read.csv(file)
    message(paste("Successfully read", file))
    return(df)
  }, error = function(e) {
    message(paste("Error reading file:", e$message))
    return(NULL)
  })
}

# Batch save plots
save_plots <- function(plot_list, output_dir, format = "pdf") {
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  
  for (name in names(plot_list)) {
    filename <- paste0(output_dir, "/", name, ".", format)
    ggsave(filename, plot_list[[name]])
  }
}
```

### Data Validation
```r
# File: validation_utils.R

# Check data requirements
check_columns <- function(df, required_cols) {
  missing <- setdiff(required_cols, names(df))
  if (length(missing) > 0) {
    stop(paste("Missing columns:", paste(missing, collapse = ", ")))
  }
  return(TRUE)
}
```

## Recommended Utilities to Create

- **data_utils.R**: Data loading, saving, validation
- **plot_utils.R**: Custom plotting functions and themes
- **stats_utils.R**: Custom statistical functions
- **text_utils.R**: Text processing helpers
- **io_utils.R**: File I/O operations
- **config.R**: Configuration and constants

## Sourcing Utilities

```r
# Load utility functions into your script
source("scripts/utilities/custom_functions.R")
source("scripts/utilities/custom_theme.R")

# Use the utility function
df <- read_safe("data.csv")
```

## File Naming

Use descriptive names:
- `*_utils.R` for utility functions
- `*_functions.R` for custom functions
- `theme_*.R` for custom themes
- `config.R` for configuration

## Example Structure

```r
################################################################################
# Script: custom_functions.R
# Purpose: Collection of reusable custom functions
# Author: Your Name
################################################################################

#' Calculate coefficient of variation
#' @param x Numeric vector
#' @return Coefficient of variation (CV)
coeff_variation <- function(x) {
  sd(x) / abs(mean(x))
}

#' Calculate standard error
#' @param x Numeric vector
#' @return Standard error
standard_error <- function(x) {
  sqrt(var(x) / length(x))
}

#' Calculate 95% confidence interval
#' @param x Numeric vector
#' @return Vector with lower and upper CI bounds
conf_interval_95 <- function(x) {
  se <- standard_error(x)
  m <- mean(x)
  c(m - 1.96 * se, m + 1.96 * se)
}
```
