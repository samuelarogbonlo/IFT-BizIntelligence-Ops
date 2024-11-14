-- models/clean_financial_data.sql
WITH src_invoice AS (
    SELECT
        id,
        date,
        currency,
        amount,
        department,
        comment
    FROM {{ ref('src_project_cost') }} 
)

SELECT
    id,
    date,
    currency,
    COALESCE(amount, 0) AS amount, 
    department,
    comment
FROM src_invoice
WHERE 
    id IS NOT NULL OR
    date IS NOT NULL OR
    currency IS NOT NULL OR
    amount IS NOT NULL OR
    department IS NOT NULL OR
    comment IS NOT NULL
