output "public_vm_ip" {
  value = azurerm_public_ip.public_vm_ip.ip_address
}

output "public_vm_name" {
  value = azurerm_linux_virtual_machine.public_vm.name
}