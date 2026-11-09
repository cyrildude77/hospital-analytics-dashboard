
SELECT
    a.admission_id,
    a.patient_id,
    a.admission_date,
    a.discharge_date,
    a.admission_type,
    a.admission_status,
    d.department_name,
    d.department_type,
    w.ward_name,
    w.ward_type,
    dis.disease_name,
    dis.disease_category,
    DATEDIFF(a.discharge_date, a.admission_date) AS length_of_stay
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
LEFT JOIN ward w
    ON a.ward_id = w.ward_id
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
ORDER BY a.admission_date;
