# Visualization Scripts

Scripts for creating publication-quality plots and interactive visualizations using ggplot2, plotly, and other visualization libraries.

## Purpose

Visualization scripts focus on:
- Static plots (publication-ready)
- Interactive visualizations
- Multi-panel figures
- Custom themes and styling
- Data storytelling through graphics

## Common Visualization Types

### Static Plots (ggplot2)
```r
library(ggplot2)

df %>%
  ggplot(aes(x = variable1, y = variable2)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = "Title",
       x = "X-axis label",
       y = "Y-axis label")
```

### Interactive Plots (plotly)
```r
library(plotly)

plot_ly(df, x = ~var1, y = ~var2, type = "scatter", mode = "markers")
```

## Recommended Packages

- **ggplot2**: Static visualization grammar
- **plotly**: Interactive web-based plots
- **ggvis**: Interactive ggplot2-like graphics
- **shiny**: Interactive applications
- **cowplot**: Multi-panel figures
- **ggthemes**: Pre-built themes
- **patchwork**: Combining plots

## Best Practices

### Color Palettes
```r
# Use colorblind-friendly palettes
library(viridis)

df %>%
  ggplot(aes(x = category, y = value, fill = group)) +
  geom_col() +
  scale_fill_viridis_d()  # Colorblind-friendly
```

### Font and Theme
```r
theme_set(theme_minimal() +
  theme(text = element_text(family = "sans", size = 12),
        plot.title = element_text(face = "bold", size = 14),
        axis.title = element_text(size = 11)))
```

### Publication-Ready Output
```r
ggsave("output/plot.pdf", width = 8, height = 6, dpi = 300)
```

## File Naming

Use descriptive names:
- `plot_*.R` for individual plots
- `viz_*.R` for visualization workflows
- `fig_*.R` for figure creation

## Example Structure

```r
################################################################################
# Script: plot_sales_by_region.R
# Purpose: Create publication-ready visualization of sales by region
# Author: Your Name
################################################################################

library(ggplot2)
library(tidyverse)
library(viridis)

# Load data
df <- read.csv("data/sales.csv")

# Create visualization
plot <- df %>%
  group_by(region) %>%
  summarise(total = sum(sales)) %>%
  ggplot(aes(x = reorder(region, -total), y = total, fill = region)) +
  geom_col() +
  scale_fill_viridis_d() +
  theme_minimal() +
  labs(title = "Sales by Region",
       x = "Region",
       y = "Total Sales ($)",
       fill = "Region") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save output
ggsave("output/sales_by_region.pdf", plot, width = 8, height = 6, dpi = 300)
print(plot)
```
