CREATE DATABASE IF NOT EXISTS hdhi_hospital;

USE hdhi_hospital;

-- Create clean reporting view matching exact HDHI columns

CREATE OR REPLACE VIEW v_HospitalAdmission AS
WITH CleanData AS (
    SELECT *, 
        ROW_NUMBER() OVER (
            PARTITION BY `MRD No.`, `D.O.A`, `D.O.D` 
            ORDER BY `MRD No.`
        ) AS Dup_No
    FROM `hdhi admission data`
)
SELECT 
    `ï»¿SNO` AS SNO,
    `MRD No.` AS Patient_MRD_No,
    STR_TO_DATE(`D.O.A`, '%c/%e/%Y') AS Date_Of_Admission,
    STR_TO_DATE(`D.O.D`, '%c/%e/%Y') AS Date_Of_Discharge,
    AGE AS Age,
    GENDER AS Gender,
    RURAL AS Rural_Locality,
    `TYPE OF ADMISSION-EMERGENCY/OPD` AS Admission_Type,
    `DURATION OF STAY` AS Duration_Of_Stay,
    OUTCOME AS Outcome,
    DM AS Diabetes,
    HTN AS Hypertension,
    CAD AS Coronary_Artery_Disease,
    CKD AS Chronic_Kidney_Disease,
    EF AS Ejection_Fraction
FROM CleanData
WHERE Dup_No = 1 
  AND `MRD No.` IS NOT NULL 
  AND `D.O.D` IS NOT NULL;
  -- Total Discharges (Filtered for normal patient discharges)
SELECT COUNT(*) AS Total_Discharges
FROM v_HospitalAdmission
WHERE Outcome = 'DISCHARGE';


-- Average Daily Discharge Rate (Total Discharges / Total Length of Stay)
SELECT 
    ROUND(SUM(CASE WHEN Outcome = 'DISCHARGE' THEN 1.0 ELSE 0.0 END) / SUM(Duration_Of_Stay), 4) * 100 AS Avg_Daily_Discharge_Rate_Percentage
FROM v_HospitalAdmission;


-- Average Length of Stay (ALOS) in Days
SELECT 
    ROUND(SUM(Duration_Of_Stay) / SUM(CASE WHEN Outcome = 'DISCHARGE' THEN 1.0 ELSE 0.0 END), 2) AS Avg_Length_Of_Stay_Days
FROM v_HospitalAdmission;


-- Distribution of Discharges by Age Group (Pediatric, Adult, Senior Citizen)
SELECT 
    CASE 
        WHEN Age < 16 THEN 'Pediatric (<16)'
        WHEN Age < 65 THEN 'Adult (16-64)'
        WHEN Age >= 65 THEN 'Senior Citizen (65+)'
        ELSE 'Unknown'
    END AS Age_Group, 
    COUNT(*) AS Discharge_Distribution
FROM v_HospitalAdmission
WHERE Outcome = 'DISCHARGE'
GROUP BY 
    CASE 
        WHEN Age < 16 THEN 'Pediatric (<16)'
        WHEN Age < 65 THEN 'Adult (16-64)'
        WHEN Age >= 65 THEN 'Senior Citizen (65+)'
        ELSE 'Unknown'
    END
ORDER BY Discharge_Distribution DESC;


-- Distribution of Discharges by Gender
SELECT 
    Gender, 
    COUNT(*) AS Discharge_Distribution
FROM v_HospitalAdmission
WHERE Outcome = 'DISCHARGE'
GROUP BY Gender
ORDER BY Discharge_Distribution DESC;

-- Discharge Bottleneck by Day of the Week
SELECT 
    DAYNAME(Date_Of_Discharge) AS Day_Of_Week, 
    COUNT(*) AS Discharge_Distribution
FROM v_HospitalAdmission
WHERE Outcome = 'DISCHARGE' AND Date_Of_Discharge IS NOT NULL
GROUP BY DAYNAME(Date_Of_Discharge), DAYOFWEEK(Date_Of_Discharge)
ORDER BY Discharge_Distribution DESC;
SELECT * FROM v_HospitalAdmission;
