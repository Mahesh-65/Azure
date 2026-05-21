module "resource_group" {
  source              = "./custom-modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source              = "./custom-modules/virtual-network"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "subnet" {
  source              = "./custom-modules/subnet"
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = module.virtual_network.vnet_name
}

module "network_security_group" {
  source              = "./custom-modules/network-security-group"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_id           = module.subnet.vmss_subnet_id
}

module "public_ip" {
  source              = "./custom-modules/public-ip"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "waf_policy" {
  source              = "./custom-modules/waf-policy"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "vmss" {
  source              = "./custom-modules/vm-scale-set"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_id           = module.subnet.vmss_subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "application_gateway" {
  source              = "./custom-modules/application-gateway"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_id           = module.subnet.appgw_subnet_id
  public_ip_id        = module.public_ip.public_ip_id
  waf_policy_id       = module.waf_policy.waf_policy_id
  domain_name         = var.domain_name
}
