variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vmss_id" {
  type = string
}

variable "min_count" {
  type = number
  default = 2
}

variable "max_count" {
  type = number
  default = 5
}

variable "default_count" {
  type = number
  default = 2
}