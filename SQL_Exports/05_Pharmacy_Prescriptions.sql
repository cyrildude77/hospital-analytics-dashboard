
SELECT
    p.prescription_id,
    p.admission_id,
    a.patient_id,
    a.admission_date,
    d.drug_id,
    d.drug_name,
    d.brand_name,
    d.drug_category,
    d.unit_cost,
    p.dosage,
    p.frequency,
    p.duration_days,
    dm.manufacturer_name,
    dm.country AS manufacturer_country
FROM prescription p
LEFT JOIN admission a
    ON p.admission_id = a.admission_id
LEFT JOIN drug d
    ON p.drug_id = d.drug_id
LEFT JOIN drug_manufacturer dm
    ON d.manufacturer_id = dm.manufacturer_id
ORDER BY a.admission_date;
