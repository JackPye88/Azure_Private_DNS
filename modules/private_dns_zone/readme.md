# Private DNS Zones Module

This Terraform module creates and manages Azure Private DNS Zones and links them to Virtual Networks.

## Purpose

Use this module to:

- Create Azure Private DNS Zones (e.g., `example.internal`)
- Link DNS zones to one or more virtual networks for name resolution

## Inputs

| Name                | Description                                 | Type   | Required |
|---------------------|---------------------------------------------|--------|----------|
| `resource_group_name` | Name of the resource group                | string | ✅       |
| `dns_zone_name`     | The name of the private DNS zone (e.g., `example.internal`) | string | ✅ |
| `vnet_id`           | The ID of the virtual network to link       | string | ✅       |

## Example Usage

```hcl
module "private_dns_zone" {
  source              = "./modules/private_dns_zone"
  resource_group_name = "my-resource-group"
  dns_zone_name       = "example.internal"
  vnet_id             = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/my-vnet"
}
