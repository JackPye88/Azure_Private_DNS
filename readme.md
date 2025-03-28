# Private DNS Zone Deployment for Azure Services

This Terraform configuration automates the creation of [Azure Private DNS Zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview) and links them to two virtual networks — one in UK South and another in UK West. It ensures name resolution for numerous Azure PaaS services using [Private Link](https://learn.microsoft.com/en-us/azure/private-link/private-link-dns).

---

## ✨ What It Does

- Creates Private DNS Zones for a list of Microsoft-managed domains (used by services like Blob Storage, Azure SQL, Key Vault, Cosmos DB, etc.)
- Links each DNS zone to:
  - A **primary** VNet: `vnet-jpd-mgmt-spoke-uks-001`
  - A **secondary** VNet: `vnet-jpd-mgmt-spoke-ukw-001`
- Tags each zone for governance and tracking

---

## 📦 Resources Created

- **Private DNS Zones**: One per domain in the `dns_zones` list (e.g., `privatelink.blob.core.windows.net`, `privatelink.database.windows.net`)
- **Virtual Network Links**: Each zone is linked to two VNets for cross-region resolution

---

## 🛠 Module Usage

The configuration uses the `private_dns_zone` module for each zone via `for_each`. Example inputs passed to the module:

```hcl
module "private_dns_zones" {
  for_each             = toset(local.dns_zones)
  source               = "./modules/private_dns_zone"
  dns_zone_name        = each.value
  resource_group_name  = "rg-jpd-con-dns-uks-001"
  primary_virtual_network_id   = data.azurerm_virtual_network.primary.id
  secondary_virtual_network_id = data.azurerm_virtual_network.secondary.id

  tags = {
    creationdate = "16.10.2024"
    deployedBy   = "jack@jackpye.co.uk"
    approvedby   = "joe@bloggs.com"
    owner        = "joe@bloggs.com"
    BU           = "IT"
    role         = "Private DNS Zone"
    environment  = "Landing Zone Platform"
  }
}
