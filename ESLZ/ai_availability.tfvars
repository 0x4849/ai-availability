subscription_id = "00000000-0000-0000-0000-000000000000"

ai_webtest_alert = {
  # Where to create AI/WebTest/ActionGroup/Alert
  rg_name     = "monitoring-dev-rg"
  location    = "canadacentral"
  name_prefix = "tfhero"
  env         = "dev"
  tags = {
    env        = "dev"
    created_by = "terraform"
    chapter    = "v30_ai_aca_availability"
  }

  # Existing LAW to query (reference only)
  law_rg_name = "logs-dev-rg"
  law_name    = "logs-dev-law"

  # Health URL you want to probe
  backend_health_url         = "https://your-public-app.example.com/health"
  web_test_frequency_seconds = 300
  web_test_geo_locations     = [
    "us-va-ash-azr",
    "us-ca-sjc-azr",
    "emea-gb-db3-azr",
  ]

  # Alert setup
  alert_emails = [
    "first.last@example.com",
    "oncall@example.com",
  ]
  app_name       = "ResumeAI"
  alert_severity = 0
  # 2 of 3 regions must fail to alert
  alert_failed_locations_threshold = 2

  # KQL: MUST produce columns AggregatedValue (number), AppName (string), FailureTimeEST (string)
  # Must include the literal token: $${WEB_TEST_NAME}
  kql_query = <<KQL
KQL
}
