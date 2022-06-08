module "sqlrg" {
  source = "github.com/DubberSoftware/dubber-terraform-modules/tree/master/msteams-ad-sync/modules/ResourceGroups"
}

resource "azurerm_storage_account" "sql" {
  name                     = "${var.prefix}sqladsyncstorage"
  resource_group_name      = module.sqlrg.sql.name
  location                 = module.sqlrg.sql.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "sqlstorageaccount" {
  value = "azurerm_storage_account.sql.name"
  sensitive = "true"
}

output "sqlstorageendpoint" {
  value = "azurerm_storage_account.sql.primary_blob_endpoint"
  sensitive = "true"
}

output "sqlprimaryaccesskey" {
  value = "azurerm_storage_account.sql.primary_access_key"
  sensitive = "true"
}
