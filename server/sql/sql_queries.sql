-- How many organizations do not have account plans?
SELECT
    COUNT(*)
FROM
    organizations o
LEFT JOIN
    account_plans a
    ON o.id = a.organization_id
WHERE
    a.id IS NULL;

-- How many organizations have more than one account plan
SELECT
    COUNT(DISTINCT ac.orgid)
FROM
    (
    SELECT
        o.id as orgid,
        COUNT(DISTINCT a.id) as acct_count
    FROM
        organizations o
        LEFT JOIN account_plans a
        on o.id = a.organization_id
    GROUP BY 1
    ) as ac
WHERE
    acct_count > 1

-- List all organizations that have only one account plan.
SELECT
    DISTINCT ac.orgid
FROM
    (
    SELECT
        o.id as orgid,
        COUNT(DISTINCT a.id) as acct_count
    FROM
        organizations o
        LEFT JOIN account_plans a
        on o.id = a.organization_id
    GROUP BY 1
    ) as ac
WHERE
    ac.acct_count = 1

-- List all organizations that have the PASSWORDLESS feature set to true.
SELECT
    DISTINCT a.organization_id
FROM
    account_plans a
WHERE
    a.features LIKE '%"PASSWORDLESS": true%';
