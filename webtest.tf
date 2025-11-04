resource "azurerm_application_insights_standard_web_test" "health" {
  name                    = coalesce(var.web_test_name, "${var.name_prefix}-${var.env}-${var.location}-health")
  location                = var.location
  resource_group_name     = var.rg_name
  application_insights_id = azurerm_application_insights.ai.id

  enabled       = true
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
      pass_if_text_found  = true
    }
  }

  tags = var.tags
}