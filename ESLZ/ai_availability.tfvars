ai_webtest_alert = {
  rg_name      = "tfhero-dev-canadacentral-rg"
  location     = "canadacentral"
  name_prefix  = "tfhero"
  env          = "dev"
  tags = {
    env        = "dev"
    created_by = "terraform"
    chapter    = "v30_ai_aca_availability"
  }

  # Reuse existing LAW (do not create)
  law_rg_name = "tfhero-dev-canadacentral-rg"
  law_name    = "tfhero-dev-canadacentral-law"

  # The URL you want to probe
  backend_health_url         = "https://your-public-app.example.com/health"

  # Synthetic test
  web_test_name              = "tfhero-dev-canadacentral-health"
  web_test_frequency_seconds = 300
  web_test_geo_locations     = ["us-va-ash-azr", "us-ca-sjc-azr", "emea-gb-db3-azr"]

  # Alert recipients + behavior
  alert_emails                     = ["firstname.lastname@myemail.ca", "br234asdf@icloud.com"]
  app_name                         = "ResumeAI"
  alert_severity                   = 0
  alert_failed_locations_threshold = 2

  # IMPORTANT: leave the literal token $${WEB_TEST_NAME}; the module replaces it.
  kql_query = <<KQL
KQL
}
