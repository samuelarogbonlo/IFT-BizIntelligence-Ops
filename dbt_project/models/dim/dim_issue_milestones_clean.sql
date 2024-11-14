WITH src_issues_milestone AS (
    SELECT
        issue_id,
        issue_url,
        due_on,
        creator,
        labels_url,
        COALESCE(description, 'No description available') AS description,
        COALESCE(open_issues, 0) AS open_issues,
        COALESCE(closed_issues, 0) AS closed_issues
    FROM {{ ref('src_issue_milestones') }}
)
SELECT 
    issue_id,
    issue_url,
    due_on,
    creator,
    labels_url,
    description,
    open_issues,
    closed_issues
FROM src_issues_milestone
