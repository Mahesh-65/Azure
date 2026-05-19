resource "azurerm_monitor_action_group" "ag" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = "alerts"

  email_receiver {
    name          = "mahesh"
    email_address = var.email_address
  }
}