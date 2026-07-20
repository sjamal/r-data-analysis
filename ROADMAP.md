# Roadmap

Planned analyses and tools across statistical modelling, data exploration, and infrastructure analytics using R.

---

## In Progress

_Nothing currently active._

---

## Planned

### Infrastructure & Operations Analytics

- [ ] **disk_growth_model.R** — Fit linear and polynomial regression models to historical disk usage time series. Forecast days-to-full with confidence intervals. Output: forecast plot + summary table.
- [ ] **incident_time_series.R** — Decompose incident/change frequency by day-of-week and hour-of-day using seasonal decomposition. Identify peak risk windows.
- [ ] **mttr_mtbf_analysis.R** — Compute Mean Time To Repair and Mean Time Between Failures from incident log data. Fit exponential distributions and visualise with ggplot2.
- [ ] **patch_compliance_trends.R** — Track patch compliance percentages over time across host groups. Produce a multi-line trend chart with annotations for patch windows.

### Statistical Analysis

- [ ] **correlation_analysis.R** — Compute and visualise Pearson/Spearman correlation matrices for infrastructure metric datasets. Highlight statistically significant pairs.
- [ ] **hypothesis_test_suite.R** — Reusable suite of common tests (t-test, Wilcoxon, chi-square, ANOVA) with automatic test selection based on data properties and formatted output.
- [ ] **regression_comparison.R** — Fit and compare linear, polynomial, and ridge regression models on a dataset. Output AIC/BIC, R², and residual plots side by side.
- [ ] **bootstrap_ci.R** — Bootstrap confidence intervals for any summary statistic (mean, median, custom function) with configurable resamples and output plots.

### Machine Learning in R

- [ ] **random_forest_classifier.R** — Train and evaluate a random forest classifier using `caret`. Includes feature importance plot, confusion matrix, and ROC curve.
- [ ] **kmeans_clustering.R** — K-means clustering of server/VM inventory by resource utilisation profile. Elbow method plot for cluster selection; outputs cluster assignments per host.
- [ ] **anomaly_detection_r.R** — Detect anomalies in metric time series using `anomalize` (Twitter's decomposition-based method). Annotated time series plot output.

### Exploratory Data Analysis

- [ ] **eda_report_template.Rmd** — RMarkdown template that auto-generates a full EDA report from any CSV: summary stats, distribution plots, correlation heatmap, missing value analysis.
- [ ] **data_profiler.R** — Script version of the EDA template for non-interactive use in pipelines. Outputs Markdown report file.

### Visualisation

- [ ] **ggplot_theme_library.R** — Custom `ggplot2` theme and colour palettes for consistent publication-ready output across all scripts in this repo.
- [ ] **facet_metric_grid.R** — Small-multiples grid of metric trends across hosts or environments using `ggplot2::facet_wrap`. Useful for comparing dozens of hosts at a glance.

---

## Ideas / Backlog

- Survival analysis for VM lifecycle (time-to-decommission modelling)
- Interactive Shiny dashboard for infrastructure cost analysis
- Bayesian inference examples using `rstan` or `brms` applied to ops data

---

## Notes

- Scripts should be runnable from the command line with `Rscript` — avoid RStudio-specific dependencies.
- Sample data for each script goes in the relevant subdirectory under `sample-data/`.
- Use `ggplot2` for all visualisation; avoid base R graphics for consistency.
- Set a fixed `set.seed()` in all scripts with stochastic elements for reproducibility.
