# Strategic Aid Allocation Analysis

This project focuses on analyzing a real-world humanitarian case study involving the allocation of emergency aid funds across 167 countries. The objective is to identify 10 priority countries that require the most urgent assistance using transparent, objective, and data-driven criteria.

The analysis emphasizes SQL-based data exploration and transformation, supported by Python for additional analysis and visualization.

---

## 🎯 Project Objective

HELP International secured an emergency fund of USD 10 million but can only provide significant impact to 10 countries.  
This project aims to build a logical and accountable framework to determine which countries should be prioritized, based on economic and health indicators rather than intuition.

---

## 📊 Dataset Overview

The dataset includes indicators across multiple dimensions:

- **Economic**: GDP per capita, income, inflation
- **Health**: Child mortality, life expectancy, health expenditure
- **Demographics**: Fertility rate
- **Trade**: Imports and exports

Total records: **167 countries**

---

## 🔍 Analysis Workflow

### 1. Global Overview
- Identified economic gaps using minimum and maximum GDP
- Analyzed countries with extreme values in fertility, life expectancy, and inflation
- Compared income levels with child mortality indicators

### 2. Feature Engineering
- Converted percentage-based indicators into real USD values
- Calculated actual health expenditure per capita
- Analyzed trade balance and income gaps

### 3. Data Grouping
- Categorized countries by economic level, fertility rate, and inflation level
- Calculated average indicators to identify macro-level patterns

### 4. Critical Zone Identification
- Determined statistical thresholds using percentiles:
  - 25th percentile of GDP per capita
  - 75th percentile of child mortality
- Filtered countries classified as high-risk ("red zone")

### 5. Final Selection & Visualization
- Selected 10 priority countries with the lowest life expectancy from the red zone
- Visualized the relationship between GDP and child mortality to support findings

---

## 🧠 Key Insights

- Countries with low GDP per capita and high child mortality consistently show lower life expectancy
- Percentile-based thresholds provide an objective method to identify humanitarian risk
- Data grouping reveals structural inequality between economic tiers

---

## 🛠️ Tools & Technologies

- **SQL** (Google BigQuery) – primary analysis tool  
- **Python** (Pandas, Matplotlib) – supporting analysis and visualization  
- **Google Colab** – analysis environment  

> Approximately 80% of the analysis was conducted using SQL queries.

---

## 📌 Output

- SQL query results for each analytical stage
- Visualizations supporting final recommendations
- A strategic recommendation identifying 10 priority countries for aid allocation

---

## 👤 Author

**Fani Fatimah Praktika**  
- GitHub: https://github.com/fanifatimahpr  
- LinkedIn: https://linkedin.com/in/fanifatimahpr  

---

## 📄 Notes

This project was developed as part of a data analytics training program at PPKD Jakarta Pusat x Plan Indonesia and is intended to demonstrate structured analytical thinking, SQL proficiency, and data-driven decision-making in a humanitarian context.
