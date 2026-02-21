install.packages(c("survival", "survminer"))
library(survival)
library(survminer)
data(lung)
head(lung)

# Convert status to a standard 0/1 (0=alive, 1=dead) for easier reading
lung$status <- lung$status - 1
# Surv(time, event)
surv_obj <- Surv(lung$time, lung$status)
head(surv_obj) 
# Note the '+' signs in the output—those indicate censored data points.
# Fit the curve (grouped by sex: 1=male, 2=female)
fit <- survfit(Surv(time, status) ~ sex, data = lung)

# Plot the results
ggsurvplot(fit, 
           data = lung,
           pval = TRUE,             # Add Log-rank test p-value
           conf.int = TRUE,         # Add confidence intervals
           risk.table = TRUE,       # Add a table showing numbers at risk
           legend.labs = c("Male", "Female"),
           palette = c("#E7B800", "#2E9FDF"),
           title = "Survival Curves for Lung Cancer Patients")
sd <- survdiff(Surv(time, status) ~ sex, data = lung)
print(sd)
# A p-value < 0.05 suggests a significant difference between groups.
# Multivariable model: sex, age, and weight loss
res.cox <- coxph(Surv(time, status) ~ sex + age + wt.loss, data = lung)
summary(res.cox)

# Visualize the Hazard Ratios (Forest Plot)
ggforest(res.cox, data = lung)
test.ph <- cox.zph(res.cox)
print(test.ph)
# If the p-value is > 0.05, the assumption holds.

# Plot residuals
ggcoxzph(test.ph)
