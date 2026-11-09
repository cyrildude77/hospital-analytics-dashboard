
SELECT
    pd.patient_diagnostic_id,
    pd.test_date,
    pd.admission_id,
    a.patient_id,
    dis.disease_name,
    dt.test_name,
    dt.test_category,
    dt.standard_cost,
    pd.result_status,
    doc.doctor_id,
    e.employee_name AS doctor_name,
    doc.specialization,
    dep.department_name
FROM patient_diagnostic pd
LEFT JOIN admission a
    ON pd.admission_id = a.admission_id
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
LEFT JOIN diagnostic_test dt
    ON pd.test_id = dt.test_id
LEFT JOIN doctor doc
    ON pd.doctor_id = doc.doctor_id
LEFT JOIN employee e
    ON doc.employee_id = e.employee_id
LEFT JOIN department dep
    ON dt.department_id = dep.department_id
ORDER BY pd.test_date;
