# Telco_Customer_Churn_Analysis
End-to-end customer churn analysis using Python (EDA), SQL, and Power BI with actionable business insights.

## 📊 Key Insights

### 📉 Churn Overview

* Total Customers: **7,043**
* Churn Rate: **~26.5%**
* Indicates a high customer attrition problem (~1 in 4 customers leave)

---

### 📌 Customer Behavior Insights

#### 1. Contract Type Impact

* Month-to-month customers show **~40%+ churn rate**
* Long-term contracts (1–2 years) show **<5% churn**

👉 Insight: Contract commitment strongly reduces churn

---

#### 2. Tenure Analysis

* Customers with tenure < 12 months have the **highest churn probability**
* Long-tenured customers show strong retention

👉 Insight: Early customer lifecycle is the most critical phase

---

#### 3. Revenue vs Churn

* Customers with **higher monthly charges** are more likely to churn
* High-value customers are at risk → potential revenue loss

---

#### 4. Service-Based Risk Segments

* Fiber optic users show **higher churn compared to DSL users**
* Customers without:

  * Tech support
  * Online security show significantly higher churn

---

#### 5. Billing & Payment Behavior

* Customers using **electronic check & paperless billing** have higher churn
* Indicates possible dissatisfaction or lower engagement

---

### ⚙️ Data Quality Handling

* Missing values found in `TotalCharges`
* Root cause: customers with zero tenure
* Resolved via:

  * Data type correction
  * Null handling strategy

---

## 💡 Business Recommendations

* Introduce incentives for **long-term contracts**
* Target **new customers (<12 months)** with retention campaigns
* Improve service quality for **fiber optic users**
* Bundle **tech support & security services**
* Monitor **high-paying customers** proactively

---

## 📈 Business Impact

* Reducing churn by even **5% can significantly increase revenue**
* Retaining customers is **5–25x cheaper than acquiring new ones**
