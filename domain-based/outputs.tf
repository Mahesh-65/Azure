output "application_gateway_public_ip" {
  description = "Public IP address of the WAF_v2 Application Gateway."
  value       = module.application_gateway.public_ip_address
}

output "routes" {
  description = "Application hostnames exposed by the Application Gateway."
  value = {
    organic = "http://organic.pronunt.com"
    fitness = "http://fitness.pronunt.com"
  }
}

output "dns_a_records" {
  description = "DNS A records to create at your DNS provider after apply."
  value = {
    "organic.pronunt.com" = module.application_gateway.public_ip_address
    "fitness.pronunt.com" = module.application_gateway.public_ip_address
  }
}

output "selected_vm_size" {
  description = "VM size used for backend VMs."
  value       = var.vm_size
}
