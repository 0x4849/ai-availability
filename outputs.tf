output "web_test_name" {
  value       = azurerm_application_insights_standard_web_test.health.name
  description = "Standard web test resource name."
}

output "action_group_emails" {
  value       = var.alert_emails
  description = "Emails configured on the Action Group."
}

output "kql_alert_name" {
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.ai_availability_failed_locations.name
  description = "KQL alert resource name."
}

output "app_insights_name" {
  value       = azurerm_application_insights.ai.name
  description = "Application Insights resource name."
}
