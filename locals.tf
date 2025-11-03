locals {
  base_name = "${var.name_prefix}-${var.env}-${var.location}"
  tags      = var.tags

  # Replace the *literal* $${WEB_TEST_NAME} token in your tfvars with the actual test name.
  kql_text = replace(var.kql_query, "$${WEB_TEST_NAME}", var.web_test_name)
}
