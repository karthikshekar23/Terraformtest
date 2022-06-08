module "sqlserverid" {
    source = "github.com/karthikshekar23/Terraformtest/tree/master/mssql"
}

module "sqlstorageendpoint" {
  source = "github.com/karthikshekar23/Terraformtest/tree/master/StorageAccount"
}

module "sqlprimaryaccesskey" {
  source = "github.com/karthikshekar23/Terraformtest/tree/master/StorageAccount"
}

resource "azurerm_mssql_database" "adsync" {
  name           = "${var.prefix}-adsync-db"
  server_id      = module.sqlserverid.sqlserverid
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "S0"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditpolicy" {
  server_id                               = module.sqlserverid.sqlserverid
  storage_endpoint                        = module.sqlstorageendpoint.sqlstorageendpoint
  storage_account_access_key              = module.sqlprimaryaccesskey.sqlprimaryaccesskey
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

output "databasename" {
  value = "azurerm_mssql_database.adsync.name"
  sensitive = true
}

