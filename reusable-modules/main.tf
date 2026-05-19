module "resource_group" {
  source = "./custom-modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source = "./custom-modules/virtual-network"

  vnet_name           = var.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  address_space       = var.address_space
}

module "subnet" {
  source = "./custom-modules/subnet"

  subnet_name         = var.subnet_name
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = module.virtual_network.vnet_name
  address_prefixes    = var.subnet_prefixes
}

module "public_ip" {
  source = "./custom-modules/public-ip"

  public_ip_name      = var.public_ip_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "load_balancer" {
  source = "./custom-modules/load-balancer"

  lb_name             = var.lb_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  public_ip_id        = module.public_ip.public_ip_id
}

module "vm_scale_set" {
  source = "./custom-modules/vm-scale-set"

  vmss_name           = var.vmss_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  subnet_id       = module.subnet.subnet_id
  backend_pool_id = module.load_balancer.backend_pool_id
}

module "autoscale" {
  source = "./custom-modules/autoscale"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  vmss_id             = module.vm_scale_set.vmss_id
}

module "action_group" {
  source = "./custom-modules/action-group"

  action_group_name   = var.action_group_name
  resource_group_name = module.resource_group.resource_group_name
  email_address       = var.email_address
}

module "alert" {
  source = "./custom-modules/alert"

  resource_group_name = module.resource_group.resource_group_name
  vmss_id             = module.vm_scale_set.vmss_id
  action_group_id     = module.action_group.action_group_id
}

module "monitor" {
  source = "./custom-modules/monitor"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "service_bus" {
  source = "./custom-modules/service-bus"

  namespace_name      = var.namespace_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "service_bus_queue" {
  source = "./custom-modules/service-bus-queue"

  queue_name  = var.queue_name
  namespace_id = module.service_bus.namespace_id
}