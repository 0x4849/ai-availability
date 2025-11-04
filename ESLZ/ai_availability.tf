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
  # tfvars set the subid
  subscription_id = var.subscription_id
}

# Single object to keep caller clean
variable "ai_webtest_alert" {
  type = any
}

# Explicit subscription id (fed via tfvars)
variable "subscription_id" {
  type = string
}

module "ai_webtest_alert" {
  source = "github.com/0x4849/ai-availability.git?ref=v0.1.0"

  # resource placement / naming
  rg_name     = var.ai_webtest_alert.rg_name
  location    = var.ai_webtest_alert.location
  name_prefix = var.ai_webtest_alert.name_prefix
  env         = var.ai_webtest_alert.env
  tags        = var.ai_webtest_alert.tags

  # existing LAW (reference only)
  law_rg_name = var.ai_webtest_alert.law_rg_name
  law_name    = var.ai_webtest_alert.law_name

  # web test
  backend_health_url         = var.ai_webtest_alert.backend_health_url
  web_test_frequency_seconds = var.ai_webtest_alert.web_test_frequency_seconds
  web_test_geo_locations     = var.ai_webtest_alert.web_test_geo_locations

  # alerting
  alert_emails                     = var.ai_webtest_alert.alert_emails
  app_name                         = var.ai_webtest_alert.app_name
  alert_severity                   = var.ai_webtest_alert.alert_severity
  alert_failed_locations_threshold = var.ai_webtest_alert.alert_failed_locations_threshold

  # KQL (must contain the literal token $${WEB_TEST_NAME})
  kql_query = var.ai_webtest_alert.kql_query
}

web_test_name = var.ai_webtest_alert.web_test_name

output "action_group_emails" {
  value = module.ai_webtest_alert.action_group_emails
}

output "kql_alert_name" {
  value = module.ai_webtest_alert.kql_alert_name
}

output "app_insights_name" {
  value = module.ai_webtest_alert.app_insights_name
}
