 Survival Analysis Report: Lung Cancer Patients

## 📌 Overview
This project applies **survival analysis techniques** to the classic `lung` dataset from the `survival` package in R. The analysis explores patient survival times, stratified by gender, and evaluates the impact of clinical variables such as age and weight loss using **Kaplan-Meier curves** and **Cox proportional hazards models**.

The report was generated on **January 16, 2026** by *Dr. Fouad Mohsen*.

---

## ⚙️ Requirements
To reproduce the analysis, install and load the following R packages:

```r
install.packages(c("survival", "survminer", "ggplot2", "ggpubr"))
library(survival)
library(survminer)
library(ggplot2)
library(ggpubr)
```

---

## 📊 Dataset
The analysis uses the `lung` dataset included in the `survival` package.  
Key variables include:

- **time**: Survival time in days  
- **status**: Event indicator (0 = censored, 1 = death)  
- **age**: Patient age  
- **sex**: Gender (1 = male, 2 = female)  
- **wt.loss**: Weight loss in the last six months  

Example rows:

| inst | time | status | age | sex | ph.ecog | ph.karno | pat.karno | meal.cal | wt.loss |
|------|------|--------|-----|-----|---------|----------|-----------|----------|---------|
| 3    | 306  | 1      | 74  | 1   | 1       | 90       | 100       | 1175     | NA      |
| 3    | 455  | 1      | 68  | 1   | 0       | 90       | 90        | 1225     | 15      |
| 3    | 1010 | 0      | 56  | 1   | 0       | 90       | 90        | NA       | 15      |

---

## 📈 Methods

### Kaplan-Meier Survival Curves
Survival curves were stratified by gender:

```r
fit <- survfit(Surv(time, status) ~ sex, data = lung)
ggsurvplot(fit, data = lung, risk.table = TRUE, palette = "Dark2",
           title = "Survival Analysis by Gender")
```

- **Result**: Female patients (sex=2) showed higher survival probability compared to males (sex=1).

---

### Cox Proportional Hazards Model
A multivariate Cox regression was fitted:

```r
res.cox <- coxph(Surv(time, status) ~ sex + age + wt.loss, data = lung)
summary(res.cox)
```

**Key findings:**
- **Sex**: Hazard ratio = 0.59 (95% CI: 0.42–0.84, p = 0.003) → Females had significantly lower risk of death.  
- **Age**: Hazard ratio = 1.02 (95% CI: 1.00–1.04, p = 0.038) → Older age slightly increased risk.  
- **Weight loss**: Not statistically significant (HR ≈ 1.00, p = 0.902).  

---

### Proportional Hazards Assumption
Tested using `cox.zph`:

```r
test.ph <- cox.zph(res.cox)
plot(test.ph)
```

- **Global test p = 0.39** → No violation of proportional hazards assumption.

---

## 📑 Results Summary
- **Gender** is a strong predictor of survival: females live longer.  
- **Age** has a modest but significant effect on survival risk.  
- **Weight loss** did not show significant association in this dataset.  
- The Cox model had **concordance = 0.612**, indicating moderate predictive ability.  

---

## 📂 Repository Structure
```
├── Survival Analysis Report Lung Cancer Patients Insights.pdf   # Full report
├── README.md                                                   # Project documentation
├── scripts/                                                    # R scripts for analysis
└── figures/                                                    # Survival plots & forest plots
```

---
🚀 How to Run
1. 	Clone the repository:

2. 	Open R or RStudio.
3. 	Run the scripts in  to reproduce the analysis.
4. 	View results in the generated plots and PDF report.

---
## 📜 License
This project is released under the **MIT License**. Feel free to use, modify, and share with attribution.

---


