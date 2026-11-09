# Hospital Analytics Dashboard

An end-to-end healthcare analytics project designed to analyze hospital operations, patient demographics, financial performance, medical diagnostics, and pharmacy inventory using **MySQL and Microsoft Excel**.

## Project Overview

Healthcare organizations generate large volumes of data across multiple departments. This project transforms hospital data into actionable insights through SQL-based data preparation, data modeling, PivotTables, and an interactive Excel dashboard.

## Business Objectives

- Analyze patient demographics and distribution.
- Monitor hospital admissions and department performance.
- Evaluate revenue, billing, and payment status.
- Understand diagnostic workload and test outcomes.
- Analyze prescription patterns and pharmacy inventory.

## Tools & Technologies

- **MySQL:** Data extraction, joins, aggregations, and data preparation.
- **Microsoft Excel:** Power Query, Data Model, relationships, PivotTables, PivotCharts, and slicers.
- **Data Analytics:** Exploratory analysis, KPI development, and business reporting.

## Dataset Overview

The project uses a synthetic hospital dataset containing 19 source CSV files.

Six consolidated analytical datasets were prepared:

| Dataset | Records |
|---|---:|
| Patient Demographics | 30,000 |
| Admission Performance | 45,000 |
| Billing Financial | 45,000 |
| Medical Diagnostics | 63,269 |
| Pharmacy Prescriptions | 73,109 |
| Pharmacy Inventory | 250 |
| **Total** | **256,628** |

## Dashboard KPIs

- Total Patients: 30,000
- Total Admissions: 45,000
- Diagnostic Records: 63,269
- Total Bills: 45,000
- Total Prescriptions: 73,109
- Inventory Medicines: 250

## Key Analytical Areas

### 1. Patient Analytics
- Gender distribution
- Age-group distribution
- Patient distribution by city
- Admissions by gender

### 2. Hospital Operations
- Monthly admission trends
- Admissions by department
- Admissions by disease
- Average length of stay
- Emergency vs. elective admissions

### 3. Financial Analytics
- Overall financial performance
- Revenue by department
- Insurance vs. patient payment contribution
- Bill payment status
- Revenue by payment mode

### 4. Medical Analytics
- Diagnostic tests by category
- Most frequently conducted tests
- Diagnostic result distribution
- Doctor-wise diagnostic workload
- Disease-wise diagnostic activity

### 5. Pharmacy & Inventory Analytics
- Most prescribed medicines
- Prescription distribution by drug category
- Manufacturer-wise prescription volume
- Inventory status distribution
- Medicines requiring reorder
- Inventory value by drug category

## Data Modeling

Six analytical tables were loaded into the Excel Data Model and connected through relationships using patient, admission, and drug identifiers.

Power Query was used for data preparation and type transformations.

## Interactive Dashboard

The executive dashboard includes KPI cards, PivotCharts, and interactive slicers for exploring hospital performance.

## Key Business Value

The dashboard helps hospital management:

- Monitor patient and admission trends.
- Identify departments with higher operational workloads.
- Understand revenue and outstanding payment patterns.
- Monitor diagnostic activity.
- Identify medicines that may require replenishment.

## Repository Structure

```text
hospital-analytics-dashboard/
│
├── README.md
├── Healthcare_Analysis_Master.xlsx
├── SQL/
│   └── SQL scripts
│
└── Dashboard_Screenshots/
    └── Executive_Dashboard.png
```

## Project Outcome

Built an integrated healthcare analytics dashboard covering 256,628 records across six analytical datasets, enabling consolidated reporting across hospital operations, finance, diagnostics, and pharmacy management.

---

**Author:** Cyril Anand  
**GitHub:** https://github.com/cyrildude77
