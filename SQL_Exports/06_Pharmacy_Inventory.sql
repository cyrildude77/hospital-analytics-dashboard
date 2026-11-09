
WITH prescription_demand AS (
    SELECT
        drug_id,
        COUNT(*) AS total_prescriptions,
        COUNT(DISTINCT admission_id) AS unique_admissions
    FROM prescription
    GROUP BY drug_id
)
SELECT
    d.drug_id,
    d.drug_name,
    d.brand_name,
    d.drug_category,
    d.unit_cost,
    dm.manufacturer_name,
    dm.country,
    dm.reliability_rating,
    di.current_stock,
    di.reorder_level,
    di.inventory_status,
    di.last_restock_date,
    (di.current_stock * d.unit_cost) AS inventory_value,
    COALESCE(pd.total_prescriptions, 0) AS total_prescriptions,
    COALESCE(pd.unique_admissions, 0) AS unique_admissions,
    CASE
        WHEN di.current_stock = 0 THEN 'Out of Stock'
        WHEN di.current_stock <= di.reorder_level THEN 'Restock Required'
        ELSE 'Sufficient Stock'
    END AS stock_recommendation
FROM drug d
JOIN drug_inventory di
    ON d.drug_id = di.drug_id
LEFT JOIN drug_manufacturer dm
    ON d.manufacturer_id = dm.manufacturer_id
LEFT JOIN prescription_demand pd
    ON d.drug_id = pd.drug_id
ORDER BY d.drug_name;
