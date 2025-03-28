
# Private DNS Zone creation
resource "azurerm_private_dns_zone" "create" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
  tags = merge( var.tags,
 {"creationdate" = formatdate("DD-MM-YYYY", timestamp()),
  })
lifecycle {
  ignore_changes = [ tags["creationdate"] ]
}
}
# Private DNS Zone Virtual Network Link Primary
resource "azurerm_private_dns_zone_virtual_network_link" "primary" {
  name                = "vnet-link-${var.dns_zone_name}-identity-spoke-primary"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.create.name
  virtual_network_id  = var.primary_virtual_network_id
  depends_on          = [azurerm_private_dns_zone.create]
}
# Private DNS Zone Virtual Network Link Secondary

resource "azurerm_private_dns_zone_virtual_network_link" "secondary" {
  count                 = var.secondary_virtual_network_id != null ? 1 : 0
  name                  = "vnet-link-${var.dns_zone_name}-identity-secondary"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.create.name
  virtual_network_id    = var.secondary_virtual_network_id
  depends_on            = [azurerm_private_dns_zone.create]
}