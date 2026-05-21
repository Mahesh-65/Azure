resource "azurerm_web_application_firewall_policy" "waf" {
  name                = "mahesh-waf-policy"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled = true
    mode    = "Prevention"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}