#gender-wise distribution of patients

SELECT
    gender,
    COUNT(*) AS total_patients,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patient),
        2
    ) AS percentage
FROM patient
GROUP BY gender
ORDER BY total_patients DESC;


#Patient distribution by city

SELECT
    city,
    COUNT(*) AS total_patients,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patient),
        2
    ) AS percentage
FROM patient
GROUP BY city
ORDER BY total_patients DESC;



#Age group distribution

SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18 THEN 'Below 18'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 30 THEN '18-30'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 31 AND 45 THEN '31-45'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END AS age_group,
    COUNT(*) AS total_patients
FROM patient
GROUP BY age_group
ORDER BY total_patients DESC;



#Blood group distribution

SELECT
    blood_group,
    COUNT(*) AS total_patients,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patient),
        2
    ) AS percentage
FROM patient
GROUP BY blood_group
ORDER BY total_patients DESC;




#Patients by admission frequency

SELECT
    admission_count,
    COUNT(*) AS total_patients
FROM (
    SELECT
        p.patient_id,
        COUNT(a.admission_id) AS admission_count
    FROM patient p
    LEFT JOIN admission a
        ON p.patient_id = a.patient_id
    GROUP BY p.patient_id
) AS patient_admissions
GROUP BY admission_count
ORDER BY admission_count;




#Top 10 patients by number of admissions

SELECT
    p.patient_id,
    p.gender,
    p.city,
    COUNT(a.admission_id) AS total_admissions
FROM patient p
JOIN admission a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.gender,
    p.city
ORDER BY total_admissions DESC
LIMIT 10;




#City-wise admission analysis

SELECT
    p.city,
    COUNT(a.admission_id) AS total_admissions,
    COUNT(DISTINCT p.patient_id) AS unique_patients,
    ROUND(
        COUNT(a.admission_id) * 1.0 /
        NULLIF(COUNT(DISTINCT p.patient_id), 0),
        2
    ) AS admissions_per_patient
FROM patient p
JOIN admission a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY total_admissions DESC;