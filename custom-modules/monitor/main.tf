resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name               = "vmss-monitor"
  target_resource_id = var.vmss_id

  metric {
    category = "AllMetrics"

    enabled = true
  }
}