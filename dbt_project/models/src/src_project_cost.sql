WITH invoice AS (
    SELECT
        (payload::jsonb->>'id')::numeric AS id,
        (payload::jsonb->>'date')::date AS date,
        payload::jsonb->>'currency' AS currency,
        (payload::jsonb->>'amount')::numeric AS amount,
        payload::jsonb->>'department' AS department,
        payload::jsonb->>'comment' AS comment
    FROM
        {{ source('raw_finance', 'invoice') }}
)

SELECT * FROM invoice