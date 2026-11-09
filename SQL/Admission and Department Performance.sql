# Total admissions by admission type

SELECT
    admission_type,
    COUNT(*) AS total_admissions,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM admission),
        2
    ) AS percentage
FROM admission
GROUP BY admission_type
ORDER BY total_admissions DESC;



#Monthly admission trends

SELECT
    DATE_FORMAT(admission_date, '%Y-%m') AS admission_month,
    COUNT(*) AS total_admissions
FROM admission
GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
ORDER BY admission_month;



#Year-wise admission trends

SELECT
    YEAR(admission_date) AS admission_year,
    COUNT(*) AS total_admissions
FROM admission
GROUP BY YEAR(admission_date)
ORDER BY admission_year;



# Department-wise admission distribution

SELECT
    d.department_name,
    COUNT(a.admission_id) AS total_admissions
FROM admission a
JOIN department d
    ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_admissions DESC;




# Average length of stay by department

SELECT
    d.department_name,
    COUNT(a.admission_id) AS total_admissions,
    ROUND(
        AVG(DATEDIFF(a.discharge_date, a.admission_date)),
        2
    ) AS avg_length_of_stay
FROM admission a
JOIN department d
    ON a.department_id = d.department_id
WHERE a.discharge_date IS NOT NULL
GROUP BY d.department_name
ORDER BY avg_length_of_stay DESC;




# Disease-wise admission analysis

SELECT
    dis.disease_name,
    dis.disease_category,
    COUNT(a.admission_id) AS total_admissions
FROM admission a
JOIN disease dis
    ON a.disease_id = dis.disease_id
GROUP BY
    dis.disease_name,
    dis.disease_category
ORDER BY total_admissions DESC;




#Ward-wise bed utilization

SELECT
    w.ward_name,
    w.total_beds,
    COUNT(b.bed_id) AS recorded_beds,
    SUM(CASE WHEN b.bed_status = 'Occupied' THEN 1 ELSE 0 END) AS occupied_beds,
    SUM(CASE WHEN b.bed_status = 'Available' THEN 1 ELSE 0 END) AS available_beds,
    ROUND(
        SUM(CASE WHEN b.bed_status = 'Occupied' THEN 1 ELSE 0 END)
        * 100.0 / NULLIF(w.total_beds, 0),
        2
    ) AS occupancy_percentage
FROM ward w
LEFT JOIN bed b
    ON w.ward_id = b.ward_id
GROUP BY
    w.ward_id,
    w.ward_name,
    w.total_beds
ORDER BY occupancy_percentage DESC;




# Department-wise emergency admissions

SELECT
    d.department_name,
    COUNT(a.admission_id) AS emergency_admissions
FROM admission a
JOIN department d
    ON a.department_id = d.department_id
WHERE a.admission_type = 'Emergency'
GROUP BY d.department_name
ORDER BY emergency_admissions DESC;




# Average length of stay by admission type

SELECT
    admission_type,
    COUNT(*) AS total_admissions,
    ROUND(
        AVG(DATEDIFF(discharge_date, admission_date)),
        2
    ) AS avg_length_of_stay,
    ROUND(
        MAX(DATEDIFF(discharge_date, admission_date)),
        2
    ) AS max_length_of_stay
FROM admission
WHERE discharge_date IS NOT NULL
GROUP BY admission_type
ORDER BY avg_length_of_stay DESC;
