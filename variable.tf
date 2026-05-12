variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "public_subnet_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "public_nsg_name" {
  type = string
}

variable "public_nic_name" {
  type = string
}

variable "public_vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "zone" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "nat_public_ip_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "private_nsg_name" {
  type = string
}

variable "private_nic_name" {
  type = string
}

variable "private_vm_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "lb_public_ip_name" {
  type = string
}