terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Optional: subscription_id = var.subscription_id
}

# One “settings” object to keep caller clean and match your pattern.
variable "ai_webtest_alert" {
  type    = any
  default = {}
}

# (Optional) If you want to force a specific subscription here:
# variable "subscription_id" { type = string }

# Unpack the object into locals for readability (optional)
locals {
  s = var.ai_webtest_alert
}

module "ai_webtest_alert" {
  # Use a relative path in ADO; use the Git URL if hosting the module in a public repo
  source = "./modules/ai-webtest-alert"

  rg_name      = local.s.rg_name
  location     = local.s.location
  name_prefix  = local.s.name_prefix
  env          = local.s.env
  tags         = try(local.s.tags, {})

  # Existing LAW reference
  law_rg_name  = local.s.law_rg_name
  law_name     = local.s.law_name

  # Web test inputs
  backend_health_url               = local.s.backend_health_url
  web_test_name                    = local.s.web_test_name
  web_test_frequency_seconds       = local.s.web_test_frequency_seconds
  web_test_geo_locations           = local.s.web_test_geo_locations

  # Alerting
  alert_emails                     = local.s.alert_emails
  app_name                         = local.s.app_name
  alert_severity                   = local.s.alert_severity
  alert_failed_locations_threshold = local.s.alert_failed_locations_threshold

  # KQL (must contain the literal token $${WEB_TEST_NAME})
  kql_query                        = local.s.kql_query
}
