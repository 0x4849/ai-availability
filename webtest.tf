# Standard Web Test (workspace-based AI)
resource "azurerm_application_insights_standard_web_test" "health" {
  name                    = "${var.name_prefix}-${var.env}-${var.location}-health"
  location                = var.location
  resource_group_name     = var.rg_name
  application_insights_id = azurerm_application_insights.ai.id

  enabled       = true
  # Provider enforces 300/600/900 only; caller must pass a valid value
  frequency     = var.web_test_frequency_seconds
  timeout       = 30
  retry_enabled = true

  geo_locations = var.web_test_geo_locations

  request {
    url       = var.backend_health_url
    http_verb = "GET"
  }

  validation_rules {
    expected_status_code = 200
    content {
      content_match       = "healthy"
      ignore_case         = true
      pass_if_text_found  = true   # IMPORTANT: "healthy" means PASS
    }
  }

  tags = var.tags
}
