# Doctor-wise admission workload

SELECT
    d.doctor_id,
    e.employee_name AS doctor_name,
    d.specialization,
    COUNT(pd.patient_diagnostic_id) AS total_diagnostic_records
FROM doctor d
JOIN employee e
    ON d.employee_id = e.employee_id
LEFT JOIN patient_diagnostic pd
    ON d.doctor_id = pd.doctor_id
GROUP BY
    d.doctor_id,
    e.employee_name,
    d.specialization
ORDER BY total_diagnostic_records DESC;




# Diagnostic tests by category

SELECT
    dt.test_category,
    COUNT(pd.patient_diagnostic_id) AS total_tests,
    COUNT(DISTINCT pd.admission_id) AS unique_admissions
FROM diagnostic_test dt
LEFT JOIN patient_diagnostic pd
    ON dt.test_id = pd.test_id
GROUP BY dt.test_category
ORDER BY total_tests DESC;




# Most frequently conducted diagnostic tests

SELECT
    dt.test_name,
    dt.test_category,
    COUNT(pd.patient_diagnostic_id) AS total_tests,
    ROUND(AVG(dt.standard_cost), 2) AS standard_test_cost
FROM diagnostic_test dt
LEFT JOIN patient_diagnostic pd
    ON dt.test_id = pd.test_id
GROUP BY
    dt.test_id,
    dt.test_name,
    dt.test_category
ORDER BY total_tests DESC
LIMIT 10;




# Diagnostic result distribution

SELECT
    result_status,
    COUNT(*) AS total_tests,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM patient_diagnostic),
        2
    ) AS percentage
FROM patient_diagnostic
GROUP BY result_status
ORDER BY total_tests DESC;




# Department-wise diagnostic activity

SELECT
    dep.department_name,
    COUNT(pd.patient_diagnostic_id) AS total_tests,
    COUNT(DISTINCT pd.admission_id) AS unique_admissions
FROM department dep
JOIN diagnostic_test dt
    ON dep.department_id = dt.department_id
LEFT JOIN patient_diagnostic pd
    ON dt.test_id = pd.test_id
GROUP BY dep.department_name
ORDER BY total_tests DESC;




# Monthly diagnostic trends

SELECT
    DATE_FORMAT(test_date, '%Y-%m') AS test_month,
    COUNT(*) AS total_tests,
    COUNT(DISTINCT admission_id) AS unique_admissions
FROM patient_diagnostic
GROUP BY DATE_FORMAT(test_date, '%Y-%m')
ORDER BY test_month;




# Most commonly prescribed drugs

SELECT
    dr.drug_name,
    dr.brand_name,
    dr.drug_category,
    COUNT(pr.prescription_id) AS total_prescriptions
FROM drug dr
LEFT JOIN prescription pr
    ON dr.drug_id = pr.drug_id
GROUP BY
    dr.drug_id,
    dr.drug_name,
    dr.brand_name,
    dr.drug_category
ORDER BY total_prescriptions DESC
LIMIT 10;





# Disease-wise diagnostic activity

SELECT
    dis.disease_name,
    dis.disease_category,
    COUNT(pd.patient_diagnostic_id) AS total_diagnostic_tests,
    COUNT(DISTINCT a.admission_id) AS total_admissions
FROM disease dis
JOIN admission a
    ON dis.disease_id = a.disease_id
LEFT JOIN patient_diagnostic pd
    ON a.admission_id = pd.admission_id
GROUP BY
    dis.disease_id,
    dis.disease_name,
    dis.disease_category
ORDER BY total_diagnostic_tests DESC;

