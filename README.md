# 🏠 Optimizing Airbnb's Two-Sided Marketplace
### A Predictive Analytics Case Study using R

![R](https://img.shields.io/badge/Language-R-blue) ![Libraries](https://img.shields.io/badge/Libraries-Tidyverse%20|%20Broom%20|%20Psych-lightgrey) ![Status](https://img.shields.io/badge/Status-Complete-green)

---

## 📋 Executive Summary
Airbnb faces the classic "Two-Sided Marketplace" challenge: balancing **Demand** (Guest Acquisition) and **Supply** (Host Recruitment). This project utilizes **Logistic Regression** to analyze 3,400+ observations, identifying statistically significant drivers for user conversion on both sides of the platform.

**Key Impacts:**
* **Marketing Efficiency:** Validated that a **$25 Coupon** campaign yields a statistically significant uplift ($p < 0.001$) compared to non-performing taxi offers.
* **Targeting Strategy:** Defined the "Ideal Guest" profile (Educated, Frequent Flyers, Gmail users), enabling precise ad targeting.
* **Supply Optimization:** Redirected host recruitment strategy to focus on **high-rated, small-capacity properties** driven by revenue potential, rather than luxury asset value.

---

## 💼 The Business Problem

Airbnb must allocate its marketing budget efficiently to scale the platform. Management is currently running A/B tests on promotions and gathering data on potential hosts, but they lack data-driven clarity on:
1.  **Demand Side:** Which promotional offer drives more sign-ups: A direct financial incentive ($25 off) or a service add-on (Free Taxi)?
2.  **Supply Side:** What characteristics define a homeowner who is likely to list their property?

---

## 🛠️ Methodology & Tech Stack

**Language:** R  
**Technique:** Logistic Regression (GLM)  
**Libraries:** `tidyverse`, `broom`, `readxl`, `psych`

I utilized **Logistic Regression** because the dependent variable in both cases is binary (`Choice = 1` for conversion, `0` for non-conversion).

1.  **Data Cleaning:** Removed non-predictive identifiers (User IDs) to prevent overfitting.
2.  **Modelling:** Fitted Binomial Logistic Regression models (`family='binomial'`) to estimate probability log-odds.
3.  **Interpretation:** Analyzed coefficients and p-values (<0.05) to determine statistical significance and directional impact.

---

## 🔬 Technical Implementation & Output

Below are the actual model outputs generated during the analysis, highlighting the key significant variables.

### 1. The Guest Acquisition Model (Demand)

**Model Specification:** `glm(Choice ~ ., family = binomial, data = customer_data)`

| Variable | Coefficient | Std. Error | z-value | P-value | Significance |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Email_25** | **0.595** | 0.136 | 4.38 | **0.000** | ⭐⭐⭐ |
| Email_Taxi | 0.215 | 0.140 | 1.53 | 0.126 | *Not Sig* |
| **Edu** | **0.515** | 0.185 | 2.79 | **0.005** | ⭐⭐ |
| **AlaskaFF** | **0.286** | 0.112 | 2.56 | **0.010** | ⭐⭐ |
| **Age** | **-0.050** | 0.007 | -7.10 | **0.000** | ⭐⭐⭐ |
| **Gmail** | **0.289** | 0.137 | 2.11 | **0.035** | ⭐ |

**Interpretation:**
* The **$25 Email** has a strong positive coefficient (0.595) with a p-value of practically zero. This confirms the hypothesis that cash incentives drive conversion.
* **Age** has a negative coefficient (-0.05), indicating that for every year older a user is, their likelihood of signing up decreases.

### 2. The Host Acquisition Model (Supply)

**Model Specification:** `glm(Choice ~ ., family = binomial, data = host_data)`

| Variable | Coefficient | Std. Error | z-value | P-value | Significance |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Rating** | **0.695** | 0.173 | 4.02 | **0.000** | ⭐⭐⭐ |
| **Guests (Capacity)**| **-0.246** | 0.114 | -2.16 | **0.031** | ⭐ |
| **Rev_AbB** | **0.002** | 0.001 | 2.46 | **0.014** | ⭐ |
| ZestimateK | -0.001 | 0.003 | -0.35 | 0.729 | *Not Sig* |

**Interpretation:**
* **Zestimate (Home Value)** is not significant ($p=0.729$). This was a crucial finding that stopped the sales team from wasting time on "luxury" homes that weren't converting.
* **Rating** is the strongest predictor. Homeowners who believe they have high-quality properties are the most likely to join.

---

## 🚀 Strategic Recommendations

Based on the model outputs above, I recommended the following actions to the stakeholder team:

| Strategy | Action Item |
| :--- | :--- |
| **Kill the Taxi Promo** | Stop the taxi campaign immediately. Reallocate budget to the **$25 Coupon** for maximum ROI. |
| **Partnership** | Launch a strategic partnership with **Alaska Airlines** to target their frequent flyer database directly. |
| **Ad Targeting** | Refine paid social targeting: Age 25-40, Interest: Travel, Education: University+, Email: Gmail. |
| **Sales Pivot** | Retool the Host Sales Pitch. Stop focusing on "Prestige" or "Home Value." Focus on **"Income Potential"** and target owners of studios/1-bedrooms. |

---

## 📂 Repository Structure

```bash
├── data/
│   ├── Airbnb Case Customer Data.csv  # 3,000 observations of guest behavior
│   └── Airbnb Case Host Data.csv      # 400 observations of homeowner behavior
├── scripts/
│   └── airbnb_acquisition_model.R     # Full R script for cleaning and regression
└── README.md
