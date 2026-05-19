output "public_ip" {
  value = module.public_ip.public_ip_address
}

output "vmss_id" {
  value = module.vm_scale_set.vmss_id
}

output "servicebus_namespace" {
  value = module.service_bus.namespace_name
}

output "queue_name" {
  value = module.service_bus_queue.queue_name
}