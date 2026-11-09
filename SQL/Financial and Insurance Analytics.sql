# Total hospital revenue and billing summary

SELECT
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_billed_amount,
    ROUND(SUM(insurance_covered_amount), 2) AS total_insurance_coverage,
    ROUND(SUM(patient_payable_amount), 2) AS total_patient_payable,
    ROUND(AVG(total_amount), 2) AS average_bill_amount
FROM billing;




# Revenue Payment by status

SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_billed_amount,
    ROUND(SUM(patient_payable_amount), 2) AS patient_payable_amount
FROM billing
GROUP BY payment_status
ORDER BY total_billed_amount DESC;




# Revenue by payment

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    ROUND(SUM(total_amount), 2) AS total_billed_amount,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM billing),
        2
    ) AS transaction_percentage
FROM billing
GROUP BY payment_mode
ORDER BY total_transactions DESC;




# Monthly billing trends

SELECT
    DATE_FORMAT(bill_date, '%Y-%m') AS billing_month,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS monthly_billed_amount,
    ROUND(SUM(patient_payable_amount), 2) AS monthly_patient_payable
FROM billing
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY billing_month;




# Department wise Revenue

SELECT
    d.department_name,
    COUNT(b.bill_id) AS total_bills,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount
FROM billing b
JOIN admission a
    ON b.admission_id = a.admission_id
JOIN department d
    ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_revenue DESC;




# Insurance coverage percentage

SELECT
    ROUND(SUM(insurance_covered_amount), 2) AS total_insurance_covered,
    ROUND(SUM(total_amount), 2) AS total_billed_amount,
    ROUND(
        SUM(insurance_covered_amount) * 100.0 /
        NULLIF(SUM(total_amount), 0),
        2
    ) AS insurance_coverage_percentage
FROM billing;




# Top 10 highest-value bills

SELECT
    b.bill_id,
    b.admission_id,
    p.patient_id,
    p.city,
    b.total_amount,
    b.insurance_covered_amount,
    b.patient_payable_amount,
    b.payment_status
FROM billing b
JOIN admission a
    ON b.admission_id = a.admission_id
JOIN patient p
    ON a.patient_id = p.patient_id
ORDER BY b.total_amount DESC
LIMIT 10;





# Revenue breakdown by charge type

SELECT
    charge_type,
    COUNT(*) AS total_charge_records,
    ROUND(SUM(amount), 2) AS total_charge_amount,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount) FROM billing_detail),
        2
    ) AS revenue_percentage
FROM billing_detail
GROUP BY charge_type
ORDER BY total_charge_amount DESC;




# Insurance provider-wise patient distribution

SELECT
    ip.provider_name,
    ip.provider_type,
    COUNT(DISTINCT pi.patient_id) AS total_patients,
    ROUND(AVG(pi.coverage_percentage), 2) AS avg_coverage_percentage
FROM patient_insurance pi
JOIN insurance_provider ip
    ON pi.insurance_provider_id = ip.insurance_provider_id
GROUP BY
    ip.provider_name,
    ip.provider_type
ORDER BY total_patients DESC;




#Outstanding patient payments

SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(patient_payable_amount), 2) AS outstanding_patient_amount,
    ROUND(AVG(patient_payable_amount), 2) AS average_patient_amount
FROM billing
WHERE payment_status = 'Pending'
GROUP BY payment_status;