-- Create the 'organizations' table
CREATE TABLE organizations (
    id UUID PRIMARY KEY,
    created_date TIMESTAMPTZ,
    updated_date TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    org_name VARCHAR(255),
    shopify_store_id BIGINT,
    my_shopify_domain VARCHAR(255),
    num_billing_retries INT,
    num_failed_cycles_before_cancel INT,
    delay_between_retries INT,
    logo VARCHAR(255),
    billing_time TIME,
    billing_timezone VARCHAR(255),
    initial_subscription_import_complete BOOLEAN,
    monthly_fee DECIMAL(10, 2),
    per_transaction_fee DECIMAL(10, 2),
    per_transaction_percentage_fee DECIMAL(5, 2),
    billing_start_date TIMESTAMPTZ,
    account JSONB,
    alloy_user_id UUID,
    active_workflows JSONB,
    setup JSONB,
    out_of_stock_behavior VARCHAR(255),
    cancellation_message TEXT,
    has_visited_retention BOOLEAN,
    rewards_point_meaning_id INT,
    has_otp_enabled BOOLEAN,
    instagram_user_data JSONB,
    looker_dashboard_prefix VARCHAR(255)
);

-- Create the 'account_plans' table
CREATE TABLE account_plans (
    created_date TIMESTAMPTZ NOT NULL,
    id UUID PRIMARY KEY,
    plan_name VARCHAR(255) NOT NULL,
    status VARCHAR(50),
    organization_id UUID NOT NULL REFERENCES organizations(id),
    features JSONB NOT NULL
);

INSERT INTO organizations (
    created_date, updated_date, id, org_name, shopify_store_id, my_shopify_domain, num_billing_retries, num_failed_cycles_before_cancel,
    delay_between_retries, billing_time, billing_timezone, initial_subscription_import_complete, account, alloy_user_id, active_workflows, setup, out_of_stock_behavior,
    cancellation_message, has_visited_retention, rewards_point_meaning_id, has_otp_enabled, instagram_user_data, looker_dashboard_prefix
)
VALUES
    ('2023-01-20 04:07:20', '2023-01-20 05:14:51', 'cce0223a-fcac-4953-9137-3c5c10c158c3', 'Test Account 1', 25571033181, 'test-account-1.myshopify.com', 3, 101, 86400, '9:00:00', 'America/Los_Angeles', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"gid://shopify/SellingPlanGroup/366280870","hasProductSelected":true,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, TRUE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-20 00:17:02', '2023-01-20 00:44:55', '75f223ec-2ede-4b38-9096-f9333d4141c7', 'Test Account 2', 35850977413, 'test-account-2.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"gid://shopify/SellingPlanGroup/208633989","hasProductSelected":true,"snippetsThemeId":"122514735237","renderingThemeId":"122514735237","isSetupFinished":true,"optimization":{"shipping":true,"theming":true,"transaction":true,"integrations":true,"retention":true}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-19 13:12:39', '2023-01-19 13:12:39', 'f7ccfc71-1858-40f4-8d03-77e3d1efb86c', 'Test Account 3', 59308736557, 'test-account-3.myshopify.com', 3, 101, 86400, '9:00:00', 'Europe/Berlin', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-19 04:55:25', '2023-01-19 04:55:25', '53980994-173e-4620-b560-2c2c437953ec', 'Test Account 4', 25729722, 'test-account-4.myshopify.com', 3, 101, 86400, '9:00:00', 'Australia/Sydney', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-19 01:54:32', '2023-01-19 14:56:28', 'c535b056-fe20-4409-ab16-a4b7c5e7dff6', 'Test Account 5', 50788368575, 'test-account-5.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"gid://shopify/SellingPlanGroup/614858943","hasProductSelected":true,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-18 21:42:39', '2023-01-18 21:46:48', '788f31b6-1418-452e-9064-28041319523d', 'Test Account 6', 68566221112, 'test-account-6.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', '63c868c71275a771dcc6fe7b', '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-18 18:25:24', '2023-01-18 18:25:27', 'adc50e61-6072-410e-9936-162ce46982ce', 'Test Account 7', 70714786071, 'test-account-7.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-18 18:24:25', '2023-01-18 18:24:40', '126c230a-f07c-4416-9406-c3758b4be772', 'Test Account 8', 69435326771, 'test-account-8.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-18 14:29:26', '2023-01-18 14:31:15', '8533ba30-ad82-41e6-9825-af3c2122d95f', 'Test Account 9', 8009744461, 'test-account-9.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"gid://shopify/SellingPlanGroup/223150157","hasProductSelected":true,"snippetsThemeId":"43449647181","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain='),
    ('2023-01-18 03:54:45', '2023-01-18 03:54:45', '88684712-d564-41be-b37f-4e8084439806', 'Test Account 10', 70699778363, 'test-account-10.myshopify.com', 3, 101, 86400, '9:00:00', 'America/New_York', FALSE, '{}', NULL, '{}', '{"selectedSellingPlanId":"","hasProductSelected":false,"snippetsThemeId":"","renderingThemeId":"","isSetupFinished":false,"optimization":{"shipping":false,"theming":false,"transaction":false,"integrations":false}}', 'CREATE_ALWAYS', NULL, FALSE, NULL, FALSE, '{}', '/embed/dashboards-next/28?embed_domain=');

INSERT INTO account_plans (
    created_date, id, plan_name, status,
    organization_id, features
)
VALUES
    ('2023-01-18 18:25:24', 'cca85c84-4724-49fd-8ff2-3917bf83cba9', 'Free Trial', 'ACTIVE', 'adc50e61-6072-410e-9936-162ce46982ce', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-20 0:17:02', 'af071cb8-abc5-4dfa-ba2e-2cf930447587', 'Excel', 'ACTIVE', '75f223ec-2ede-4b38-9096-f9333d4141c7', '{"CORE_CONFIGURATION":true,"CORE_SUBSCRIPTIONS":true,"LOOKER_ANALYTICS":true,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":true,"SEQUENTIAL_SELLING_PLAN":true,"MIGRATIONS":true,"BUNDLES":true,"LOYALTY":true,"TRANSLATIONS":true,"PASSWORDLESS": true}'),
    ('2023-01-20 4:07:20', '05078458-d1c4-4221-b702-057c33f7e8ee', 'Free Trial', 'ACTIVE', 'cce0223a-fcac-4953-9137-3c5c10c158c3',	'{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-18 21:42:39',	'e91e2145-aaef-4e6c-996d-8efd7f75f11c','Free Trial', 'ACTIVE','788f31b6-1418-452e-9064-28041319523d', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-19 4:55:25','5ef30cf7-50ce-4456-88c7-218b47588515','Free Trial','ACTIVE','53980994-173e-4620-b560-2c2c437953ec','{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-19 01:54:32', '8217d6fb-911f-4da4-be35-e8cbf091fb62', 'Free Trial', 'CANCELLED', 'c535b056-fe20-4409-ab16-a4b7c5e7dff6', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-18 14:29:26', '04eceded-2972-46f0-ac24-b69745ddcb95', 'Free Trial', 'ACTIVE', '8533ba30-ad82-41e6-9825-af3c2122d95f', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-18 18:24:25', 'c01594fe-785a-4d6f-a449-8d30be99dd18', 'Free Trial', 'ACTIVE', '126c230a-f07c-4416-9406-c3758b4be772', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}'),
    ('2023-01-19 01:54:32', '111da83a-98d0-11ed-a8fc-0242ac120002', 'Grow', 'ACTIVE', 'c535b056-fe20-4409-ab16-a4b7c5e7dff6', '{"CORE_SUBSCRIPTIONS":true,"CORE_CONFIGURATION":true,"ANALYTICS":true,"LOOKER_ANALYTICS":false,"SHOPIFY_DEBUG":false,"RETENTION":true,"INTEGRATIONS":true,"PREPAID_SELLING_PLAN":false,"SEQUENTIAL_SELLING_PLAN":true,"ADVANCED_SEQUENTIAL_SELLING_PLAN":false,"SETUP":false,"LOYALTY":false,"BUNDLES":false,"TRANSLATIONS":false,"PASSWORDLESS":false,"TRENDING":false}');
