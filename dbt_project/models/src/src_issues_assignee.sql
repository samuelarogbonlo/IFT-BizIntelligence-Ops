WITH issues_assignee AS (
    SELECT
        id as issue_id,
        url as issue_url,
        type,
        login,
        gists_url,
        repos_url,
        avatar_url,
        site_admin,
        gravatar_id,
        starred_url,
        followers_url,
        following_url,
        organizations_url,
        subscriptions_url,
        received_events_url
    FROM {{ source('raw_github', 'issues_assignee') }} 
)

SELECT * FROM issues_assignee
