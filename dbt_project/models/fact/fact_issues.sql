WITH src_issues AS (
    SELECT
        issue_id,
        issue_url,
        COALESCE(TRIM(body), 'No description') AS body,   
        COALESCE(draft, false) AS draft,                 
        COALESCE(state, 'unknown') AS issue_state,           
        TRIM(title) AS title,                                      
        COALESCE("locked", false) AS "locked",           
        COALESCE("number", 0) AS "number",              
        COALESCE(node_id, 'No node_id') AS node_id,      
        COALESCE(user_id, 0) AS user_id,                           
        TRIM(html_url) AS html_url,                     
        COALESCE(closed_at, created_at) AS closed_at, 
        created_at,
        COALESCE(events_url, 'No events URL') AS events_url,  
        labels_url,
        COALESCE(repository, 'Unknown repository') AS repository,
        updated_at,
        COALESCE(comments_url, 'No comments URL') AS comments_url, 
        pull_request,
        state_reason,
        timeline_url,
        repository_url,
        active_lock_reason,
        COALESCE(author_association, 'None') AS author_association,  
        performed_via_github_app
    FROM {{ ref('src_issues') }} 
)

SELECT 
    * 
FROM src_issues
