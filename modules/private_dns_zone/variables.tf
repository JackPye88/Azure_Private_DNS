variable "dns_zone_name" {
  type        = string
  description = "The name of the private DNS zone."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "primary_virtual_network_id" {
  type        = string
  description = "Primary virtual network ID to link to."
}

variable "secondary_virtual_network_id" {
  type        = string
  description = "Optional secondary virtual network ID to link to."
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}