WITH issues_labels_data AS (
    SELECT
        id as issue_id,
        url as issue_url,
        "name" as label_name,
        color,
        "default",
        description
    FROM {{ source('raw_github', 'issues_labels') }}
)
SELECT 
    issue_id,
    issue_url,
    label_name,
    color,
    "default",
    description
FROM issues_labels_data
