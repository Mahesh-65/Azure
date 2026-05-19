resource "azurerm_monitor_metric_alert" "alert" {
  name                = "cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.vmss_id]

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }

  action {
    action_group_id = var.action_group_id
  }
}