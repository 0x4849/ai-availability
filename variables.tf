variable "rg_name" {
  type        = string
  description = "Resource Group where AI/Web Test/AG/Alert will be created."
}

variable "location" {
  type        = string
  description = "Azure region for AI/Web Test/AG/Alert."
}

variable "name_prefix" {
  type        = string
  description = "Base prefix for resource names (e.g., tfhero)."
}

variable "env" {
  type        = string
  description = "Environment string (e.g., dev/test/prod)."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources."
}

variable "law_rg_name" {
  type        = string
  description = "Resource Group of the existing Log Analytics Workspace."
}

variable "law_name" {
  type        = string
  description = "Name of the existing Log Analytics Workspace."
}

variable "backend_health_url" {
  type        = string
  description = "Public URL to probe (e.g., https://app/health)."
}

variable "web_test_frequency_seconds" {
  type        = number
  description = "Standard Web Test frequency in seconds (allowed: 300, 600, 900)."
}

variable "web_test_geo_locations" {
  type        = list(string)
  description = "List of probe location IDs for the Standard Web Test."
}

variable "alert_emails" {
  type        = list(string)
  description = "Email recipients for the Action Group."
}

variable "app_name" {
  type        = string
  description = "Logical app name to show in the alert title/body."
}

variable "alert_severity" {
  type        = number
  description = "Alert severity (0-4)."
}

variable "alert_failed_locations_threshold" {
  type        = number
  description = "Trigger alert when >= this many probe locations fail in the window."
}

variable "kql_query" {
  type        = string
  description = "KQL used by the alert; must include $${WEB_TEST_NAME} and produce AggregatedValue, AppName, FailureTimeEST."
}
