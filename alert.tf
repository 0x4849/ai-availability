resource "azurerm_monitor_scheduled_query_rules_alert_v2" "ai_availability_failed_locations" {
  name                = "${var.name_prefix}-${var.env}-${var.location}-health-kql-alert"
  display_name        = "FATAL: unable to reach ${var.app_name}"
  resource_group_name = var.rg_name
  location            = var.location

  scopes                  = [data.azurerm_log_analytics_workspace.law.id]
  description             = "Fatal Error: unable to reach ${var.app_name} backend. Triggers when >= ${var.alert_failed_locations_threshold} locations fail in the last 5 minutes."
  enabled                 = true
  severity                = var.alert_severity
  evaluation_frequency    = "PT5M"
  window_duration         = "PT5M"
  auto_mitigation_enabled = false

  criteria {
    # Use the KQL from tfvars and inject the actual web test name
    query = replace(var.kql_query, "$${WEB_TEST_NAME}", azurerm_application_insights_standard_web_test.health.name)

    metric_measure_column   = "AggregatedValue"
    time_aggregation_method = "Total"
    operator                = "GreaterThanOrEqual"
    threshold               = var.alert_failed_locations_threshold

    failing_periods {
      number_of_evaluation_periods             = 1
      minimum_failing_periods_to_trigger_alert = 1
    }
  }

  # Pretty subject/body in Eastern Time, no LAW mentioned
  alert_details_override {
    alert_subject_format     = "FATAL: unable to reach {{AppName}} backend at {{FailureTimeEST}} (ET)"
    alert_description_format = "Unable to reach the backend health endpoint.\nApp={{AppName}}\nFailedLocations={{AggregatedValue}}\nTime (ET)={{FailureTimeEST}}\nURL=${var.backend_health_url}"
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag.id]
    custom_properties = {
      app_name    = var.app_name
      health_url  = var.backend_health_url
      environment = var.env
      region      = var.location
    }
  }

  tags = var.tags

  depends_on = [azurerm_application_insights_standard_web_test.health]
}
