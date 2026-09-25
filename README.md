# Amex Card Member Analysis & Customer Behaviour

## Project Overview

This project analyzes American Express card member and transaction data to understand **customer spending behaviour, transaction patterns, category preferences, and other factors influencing credit card usage**.

The project follows an end-to-end data analytics workflow, starting with exploratory analysis and progressing through SQL analysis, statistical validation, business insights, and interactive Power BI visualization.

---

## Project Objectives

The key objectives of this project are to:

* Explore and understand the structure of the card member dataset.
* Analyze customer spending behaviour and transaction patterns.
* Identify trends across spending categories and customer segments.
* Examine relationships between different customer and transaction attributes.
* Use SQL to answer business-oriented analytical questions.
* Apply statistical analysis to validate observed patterns.
* Convert analytical findings into meaningful business insights.
* Develop an interactive Power BI dashboard based on the identified insights.

---

## Project Workflow

The analysis is organized into the following stages:

### 01. Exploratory Data Analysis (EDA)

The first stage focuses on understanding and preparing the dataset.

Key activities include:

* Dataset structure and dimensions
* Data types and column analysis
* Missing-value analysis
* Duplicate-value analysis
* Descriptive statistics
* Univariate analysis
* Bivariate analysis
* Distribution analysis
* Outlier detection
* Data cleaning and preparation

**Output:** A cleaned dataset that is used for the subsequent SQL analysis.

---

### 02. SQL Analysis

The cleaned dataset is imported into SQL for business-oriented analysis.

This stage focuses on answering analytical questions such as:

* Customer spending patterns
* Transaction trends
* Category-level spending
* City-level behaviour
* Customer segmentation
* Spending distribution
* High-value and low-value transaction patterns
* Other business-specific questions derived from the dataset

**Output:** SQL-based findings and analytical results.

---

### 03. Statistical Analysis

Statistical techniques are used to investigate and validate patterns identified during the exploratory and SQL analysis.

This stage helps determine whether observed differences and relationships are statistically meaningful rather than being based only on visual or descriptive patterns.

**Output:** Statistically supported findings.

---

### 04. Business Insights

The results from EDA, SQL, and statistical analysis are translated into business-oriented insights.

This stage focuses on:

* Identifying important customer behaviour patterns
* Understanding spending trends
* Highlighting meaningful customer segments
* Identifying potential business opportunities
* Connecting analytical findings with possible business implications

These insights form the foundation for the final dashboard.

---

### 05. Power BI Dashboard

The final stage converts the key business insights into an interactive Power BI dashboard.

The dashboard is designed to provide a visual overview of:

* Customer behaviour
* Spending patterns
* Transaction trends
* Category performance
* Customer segments
* Key performance indicators
* Other important findings identified during the analysis

The dashboard is therefore built **based on the insights generated during the earlier stages of the project**.

---

## Tools & Technologies

* **Python**
* **Jupyter Notebook**
* **Pandas**
* **NumPy**
* **Matplotlib**
* **Seaborn**
* **SQL**
* **MySQL**
* **Power BI**
* **GitHub**

---

## Repository Structure

```text
Amex_card_member_analysis/
│
├── README.md
│
├── 01_EDA/
│   ├── README.md
│   ├── Amex_EDA.ipynb
│   └── Amex_Cleaned_Data.csv
│
├── 02_SQL/
│   ├── README.md
│   └── Amex_SQL_Analysis.sql
│
├── 03_Statistical_Analysis/
│   ├── README.md
│   └── Statistical_Analysis.ipynb
│
├── 04_Business_Insights/
│   ├── README.md
│   └── Business_Insights.md
│
└── 05_PowerBI_Dashboard/
    ├── README.md
    ├── Amex_Dashboard.pbix
    └── Dashboard_Preview.png
```

---

## Analytical Approach

The project follows a structured analytical approach:

**Raw Data**
↓
**Exploratory Data Analysis**
↓
**Data Cleaning & Preparation**
↓
**SQL Business Analysis**
↓
**Statistical Analysis**
↓
**Business Insights**
↓
**Power BI Dashboard**

This approach ensures that the final dashboard is supported by the underlying analysis rather than being created solely for visualization purposes.

---

## Disclaimer

> **Disclaimer:** This project is created for educational, portfolio, and data analytics practice purposes. The dataset used in this project is **not official American Express data** and should not be considered representative of American Express's actual customers, transactions, business operations, or performance. Any names, data, findings, visualizations, or business insights presented in this repository are based solely on the dataset used for this project and are intended only for analytical demonstration.

This project is **not affiliated with, sponsored by, endorsed by, or officially associated with American Express.**
