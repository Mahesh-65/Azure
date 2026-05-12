variable "location" {
  description = "Azure Region"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-non-transitive-peering"
}

variable "vm_size" {
  description = "Azure VM Size"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "admin_username" {
  description = "Admin Username"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin Password"
  type        = string
  default     = "Mahesh@050903"
  sensitive   = true
}