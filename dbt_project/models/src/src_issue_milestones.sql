WITH issues_milestone AS (
    SELECT
        id as issue_id,
        url as issue_url,
        due_on,
        creator,
        labels_url,
        description,
        open_issues,
        closed_issues
    FROM {{ source('raw_github', 'issues_milestone') }} 
)

SELECT * FROM issues_milestone
