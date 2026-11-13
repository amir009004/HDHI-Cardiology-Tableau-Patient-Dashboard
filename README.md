# HDHI Cardiology Clinical Inpatient Admissions Dashboard

An end-to-end clinical data analytics project utilizing SQL and Tableau Public to analyze inpatient cardiology admissions from the HDHI dataset (Ludhiana, India).

The dataset originates from Hero DMC Heart Institute, affiliated with Dayanand Medical College and Hospital in Ludhiana, Punjab, India. It covers a two-year period from April 2017 to March 2019 and contains cardiology inpatient admission records. The data includes patient demographics, admission and discharge dates, admission types, clinical history, and other patient-related medical information. This project specifically uses the HDHI Admission data.csv file to examine inpatient discharge volumes, admission channels, and demographic patterns.

## Project Overview
- **Total Patient Discharges Analyzed:** 12,182
- **Tools Used:** MySQL Workbench, Tableau Public, SQL, Data Modeling

## Key Insights & Visualizations
1. **Total Volume KPI:** High-level executive summary tracking total inpatient throughput and operational volume.
2. **Emergency vs. OPD Intake:** Comparative analysis evaluating patient admission channels between emergency and outpatient departments.
3. **Discharge Distribution by Day of Week:** Operational workflow tracking across weekly cycles to uncover admission and discharge patterns.
4. **Age & Gender Demographics:** Stacked distribution histogram highlighting peak cardiology admission brackets (ages 50-70) split by gender.

## Data Architecture & Pipeline
- **Database Schema & Views:** Cleaned raw patient data in MySQL Workbench by structuring custom views (`v_HospitalAdmission`) to standardize dates, handle patient tracking numbers (`Patient MRD No`), and manage aggregation integrity.
- **Data Export & Transformation:** Handled dataset extraction limits and verified full multi-thousand record counts to ensure complete clinical reporting fidelity without row truncation.

## Key Results & Insights
- **Patient Volume Throughput:** Processed and analyzed **12,182 verified patient discharges**, providing a comprehensive macro-level view of hospital operational flow.
- **Intake Channel Distribution:** Highlighted the split between Emergency and Outpatient Department (OPD) admissions, showing that emergency intake forms the majority of cardiology admissions.
- **Weekly Operational Cadence:** Discharges remain relatively steady across weekdays with a slight dip on Sundays, aiding staffing and resource allocation analysis.
- **Demographic Risk Concentration:** The Age Distribution histogram reveals that cardiology admissions heavily concentrate in the **50-70 age bracket**, with distinct volume splits between male and female cohorts.

## Interactive Dashboard
View the live interactive dashboard on Tableau Public: [Clinical Inpatient Admissions Overview](https://public.tableau.com/views/HospitalInpatientDataVisualizations/ClinicalInpatientAdmissionsOverview?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Dataset
Sahani, Ashish. “Hospital Admissions Data.” Kaggle.  
https://www.kaggle.com/datasets/ashishsahani/hospital-admissions-data/data?select=HDHI+Admission+data.csv
