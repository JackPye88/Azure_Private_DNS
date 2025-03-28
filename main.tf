locals {
  dns_zones = [
    "privatelink.adf.azure.com",
    "privatelink.afs.azure.net",
    "privatelink.agentsvc.azure-automation.net",
    "privatelink.analysis.windows.net",
    "privatelink.api.azureml.ms",
    "privatelink.azconfig.io",
    "privatelink.azure-api.net",
    "privatelink.azure-automation.net",
    "privatelink.azure-devices-provisioning.net",
    "privatelink.azure-devices.net",
    "privatelink.azurecr.io",
    "privatelink.azurehdinsight.net",
    "privatelink.azurehealthcareapis.com",
    "privatelink.azurestaticapps.net",
    "privatelink.azuresynapse.net",
    "privatelink.azurewebsites.net",
    "privatelink.batch.azure.com",
    "privatelink.blob.core.windows.net",
    "privatelink.cassandra.cosmos.azure.com",
    "privatelink.cognitiveservices.azure.com",
    "privatelink.database.windows.net",
    "privatelink.datafactory.azure.net",
    "privatelink.dev.azuresynapse.net",
    "privatelink.developer.azure-api.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.dicom.azurehealthcareapis.com",
    "privatelink.digitaltwins.azure.net",
    "privatelink.directline.botframework.com",
    "privatelink.documents.azure.com",
    "privatelink.eventgrid.azure.net",
    "privatelink.file.core.windows.net",
    "privatelink.gremlin.cosmos.azure.com",
    "privatelink.guestconfiguration.azure.com",
    "privatelink.his.arc.azure.com",
    "privatelink.kubernetesconfiguration.azure.com",
    "privatelink.managedhsm.azure.net",
    "privatelink.mariadb.database.azure.com",
    "privatelink.media.azure.net",
    "privatelink.mongo.cosmos.azure.com",
    "privatelink.monitor.azure.com",
    "privatelink.mysql.database.azure.com",
    "privatelink.notebooks.azure.net",
    "privatelink.ods.opinsights.azure.com",
    "privatelink.oms.opinsights.azure.com",
    "privatelink.pbidedicated.windows.net",
    "privatelink.postgres.database.azure.com",
    "privatelink.prod.migration.windowsazure.com",
    "privatelink.purview.azure.com",
    "privatelink.purviewstudio.azure.com",
    "privatelink.queue.core.windows.net",
    "privatelink.redis.cache.windows.net",
    "privatelink.redisenterprise.cache.azure.net",
    "privatelink.search.windows.net",
    "privatelink.service.signalr.net",
    "privatelink.servicebus.windows.net",
    "privatelink.siterecovery.windowsazure.com",
    "privatelink.sql.azuresynapse.net",
    "privatelink.table.core.windows.net",
    "privatelink.table.cosmos.azure.com",
    "privatelink.tip1.powerquery.microsoft.com",
    "privatelink.token.botframework.com",
    "privatelink.uks.backup.windowsazure.com",
    "privatelink.ukw.backup.windowsazure.com",
    "privatelink.vaultcore.azure.net",
    "privatelink.web.core.windows.net",
    "privatelink.webpubsub.azure.com",
  ]
}

data "azurerm_virtual_network" "primary" {
    provider = azurerm.identity
  name                = "vnet-jpd-mgmt-spoke-uks-001"
  resource_group_name = "rg-jpd-mgmt-spoke-uks-001"
}
data "azurerm_virtual_network" "secondary" {
        provider = azurerm.identity

  name                = "vnet-jpd-mgmt-spoke-ukw-001"
  resource_group_name = "rg-jpd-mgmt-spoke-ukw-001"
}

module "private_dns_zones" {

  for_each             = toset(local.dns_zones)
  source               = "./modules/private_dns_zone"
  dns_zone_name        = each.value
  resource_group_name  = "rg-jpd-con-dns-uks-001"
  primary_virtual_network_id   = data.azurerm_virtual_network.primary.id #VNET ID OF Network Primary Domain Controller is on
  secondary_virtual_network_id = data.azurerm_virtual_network.secondary.id #VNET ID OF Network Secondary Domain Controller is on
 tags = {
    creationdate = "16.10.2024", # Date of creation
  deployedBy   = "jack@jackpye.co.uk", # Deployed by email
  approvedby   = "joe@bloggs.com", # Approved by email
  owner        = "joe@bloggs.com", # Customer Owner email
  BU           = "IT", # Business Unit
  role = "Private DNS Zone"
  environment  = "Landing Zone Platform" # Environment description
 }
}