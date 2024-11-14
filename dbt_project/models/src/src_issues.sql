WITH issues AS (
    SELECT
        id as issue_id,
        url as issue_url,
        body,
        draft,
        state,
        title,
        "locked",
        "number",
        node_id,
        user_id,
        html_url,
        closed_at,
        created_at,
        events_url,
        labels_url,
        repository,
        updated_at,
        comments_url,
        pull_request,
        state_reason,
        timeline_url,
        repository_url,
        active_lock_reason,
        author_association,
        performed_via_github_app
    FROM {{ source('raw_github', 'issues') }} 
)
SELECT 
    * 
FROM issues
