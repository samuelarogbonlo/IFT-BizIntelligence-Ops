WITH src_issues_assignee AS (
    SELECT
        issue_id,
        issue_url,
        COALESCE(type, 'Unknown') AS type,
        COALESCE(login, 'Anonymous') AS assignee_login,
        gists_url,
        repos_url,
        COALESCE(avatar_url, 'https://example.com/default-avatar.png') AS avatar_url,
        COALESCE(site_admin, FALSE) AS site_admin,
        gravatar_id,
        starred_url,
        followers_url,
        following_url,
        organizations_url,
        subscriptions_url,
        received_events_url
    FROM {{ ref('src_issues_assignee') }} 
)

SELECT 
    issue_id,
    issue_url,
    type,
    assignee_login,
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
FROM src_issues_assignee
