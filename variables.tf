variable "rg_name" {
  type        = string
  description = "Resource group where AI, Web Test, Action Group, and Alert will be created."
}

variable "location" {
  type        = string
  description = "Azure region for AI/Web Test/Alert (e.g., canadacentral)."
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names (e.g., tfhero)."
}

variable "env" {
  type        = string
  description = "Logical environment (e.g., dev/test/prod)."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources."
}

variable "law_rg_name" {
  type        = string
  description = "Resource group name where the existing LAW lives."
}

variable "law_name" {
  type        = string
  description = "Existing Log Analytics Workspace name."
}

variable "backend_health_url" {
  type        = string
  description = "Public health URL to probe, e.g., https://app.example.com/health"
}

variable "alert_emails" {
  type        = list(string)
  description = "List of email addresses for the action group notifications."
}

variable "app_name" {
  type        = string
  description = "Friendly application name used in alert text."
}

variable "alert_severity" {
  type        = number
  description = "Azure Monitor alert severity (0=Sev0 .. 4=Sev4)."
}

variable "web_test_frequency_seconds" {
  type        = number
  description = "How often to probe (seconds). Must be 300, 600, or 900."
  validation {
    condition     = contains([300, 600, 900], var.web_test_frequency_seconds)
    error_message = "web_test_frequency_seconds must be 300, 600, or 900."
  }
}

variable "web_test_geo_locations" {
  type        = list(string)
  description = "List of public web test location IDs (e.g., us-va-ash-azr, us-ca-sjc-azr, emea-gb-db3-azr)."
}

variable "alert_failed_locations_threshold" {
  type        = number
  description = "Trigger alert when failed locations >= this value in the 5-minute window."
}

variable "web_test_name" {
  type        = string
  description = "Synthetic monitor (web test) resource name."
}

variable "kql_query" {
  type        = string
  description = "Full KQL with the literal token $${WEB_TEST_NAME}. Must project a numeric column named AggregatedValue."
}
