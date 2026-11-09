# Drug inventory overview

SELECT
    COUNT(*) AS total_drugs,
    SUM(current_stock) AS total_units_in_stock,
    SUM(CASE WHEN inventory_status = 'Low Stock' THEN 1 ELSE 0 END) AS low_stock_drugs,
    SUM(CASE WHEN inventory_status = 'Out of Stock' THEN 1 ELSE 0 END) AS out_of_stock_drugs,
    SUM(CASE WHEN inventory_status = 'In Stock' THEN 1 ELSE 0 END) AS in_stock_drugs
FROM drug_inventory;




# Drugs requiring restocking

SELECT
    d.drug_id,
    d.drug_name,
    d.brand_name,
    di.current_stock,
    di.reorder_level,
    (di.reorder_level - di.current_stock) AS stock_shortage,
    di.inventory_status
FROM drug_inventory di
JOIN drug d
    ON di.drug_id = d.drug_id
WHERE di.current_stock <= di.reorder_level
ORDER BY stock_shortage DESC;




# Drug category-wise inventory

SELECT
    d.drug_category,
    COUNT(d.drug_id) AS total_drugs,
    SUM(di.current_stock) AS total_units,
    ROUND(AVG(di.current_stock), 2) AS avg_stock_per_drug
FROM drug d
JOIN drug_inventory di
    ON d.drug_id = di.drug_id
GROUP BY d.drug_category
ORDER BY total_units DESC;




# Most frequently prescribed drug categories

SELECT
    d.drug_category,
    COUNT(p.prescription_id) AS total_prescriptions,
    COUNT(DISTINCT p.admission_id) AS unique_admissions
FROM drug d
JOIN prescription p
    ON d.drug_id = p.drug_id
GROUP BY d.drug_category
ORDER BY total_prescriptions DESC;




# Top 10 most prescribed drugs

SELECT
    d.drug_name,
    d.brand_name,
    d.drug_category,
    COUNT(p.prescription_id) AS total_prescriptions,
    COUNT(DISTINCT p.admission_id) AS unique_admissions
FROM drug d
JOIN prescription p
    ON d.drug_id = p.drug_id
GROUP BY
    d.drug_id,
    d.drug_name,
    d.brand_name,
    d.drug_category
ORDER BY total_prescriptions DESC
LIMIT 10;




# Inventory value by drug category

SELECT
    d.drug_category,
    SUM(di.current_stock) AS total_units,
    ROUND(SUM(di.current_stock * d.unit_cost), 2) AS inventory_value
FROM drug d
JOIN drug_inventory di
    ON d.drug_id = di.drug_id
GROUP BY d.drug_category
ORDER BY inventory_value DESC;



# Manufacturer-wise inventory analysis

SELECT
    dm.manufacturer_name,
    dm.country,
    dm.reliability_rating,
    dm.contract_status,
    COUNT(DISTINCT d.drug_id) AS total_drugs,
    SUM(di.current_stock) AS total_units,
    ROUND(SUM(di.current_stock * d.unit_cost), 2) AS inventory_value
FROM drug_manufacturer dm
JOIN drug d
    ON dm.manufacturer_id = d.manufacturer_id
JOIN drug_inventory di
    ON d.drug_id = di.drug_id
GROUP BY
    dm.manufacturer_id,
    dm.manufacturer_name,
    dm.country,
    dm.reliability_rating,
    dm.contract_status
ORDER BY inventory_value DESC;




# Prescription demand versus current stock

SELECT
    d.drug_id,
    d.drug_name,
    d.drug_category,
    COUNT(p.prescription_id) AS total_prescriptions,
    di.current_stock,
    di.reorder_level,
    di.inventory_status,
    CASE
        WHEN di.current_stock = 0 THEN 'Critical - Out of Stock'
        WHEN di.current_stock <= di.reorder_level THEN 'Restock Required'
        WHEN COUNT(p.prescription_id) >= 300 THEN 'High Demand'
        ELSE 'Adequate Stock'
    END AS stock_recommendation
FROM drug d
LEFT JOIN prescription p
    ON d.drug_id = p.drug_id
JOIN drug_inventory di
    ON d.drug_id = di.drug_id
GROUP BY
    d.drug_id,
    d.drug_name,
    d.drug_category,
    di.current_stock,
    di.reorder_level,
    di.inventory_status
ORDER BY total_prescriptions DESC;
