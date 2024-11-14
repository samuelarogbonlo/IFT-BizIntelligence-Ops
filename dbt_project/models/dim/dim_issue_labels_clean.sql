WITH src_issues_labels AS (
    SELECT
        issue_id,
        issue_url,
        label_name,
        color,
        "default",
        description
    FROM {{ ref('src_issues_labels') }}
)

SELECT 
    issue_id,
    issue_url,
    COALESCE(label_name, 'Unknown') AS label_name,
    COALESCE(color, 'N/A') AS color,
    COALESCE("default", FALSE) AS default_flag,
    COALESCE(description, 'No description available') AS description
FROM src_issues_labels
