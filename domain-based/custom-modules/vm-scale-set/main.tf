resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "mahesh-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku       = "Standard_DC1ds_v3"
  instances = 2
  zones     = ["3"]

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = 30
  }

  network_interface {
    name    = "vmssnic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }
}