module "sqlrg" {
  source = "github.com/DubberSoftware/dubber-terraform-modules/tree/master/msteams-ad-sync/modules/ResourceGroups"
}

module "sqlrgloc" {
  source = "github.com/DubberSoftware/dubber-terraform-modules/tree/master/msteams-ad-sync/modules/ResourceGroups"
}


resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.prefix}adsyncmssqlserver"
  resource_group_name          = module.sqlrg.sqlrg
  location                     = module.sqlrgloc.sqlrgloc
  version                      = "12.0"
  administrator_login          = "sadministrator"
  administrator_login_password = "sdujef$@s123"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "4f819731-fe05-4078-9e62-c13ef58035fc"
  }

  tags = {
    environment = "dev"
  }
}

output "sqlserverid" {
  value = "azurerm_mssql_server.sqlserver.id"
  sensitive = true
}

output "sqlservername" {
  value = "azurerm_mssql_server.sqlserver.name"
  sensitive = true
}

output "sqlserverlocation" {
  value = "azurerm_mssql_server.sqlserver.location"
  sensitive = true
}

output "sqlserverversion" {
  value = "azurerm_mssql_server.sqlserver.version"
  sensitive = true
}

output "sqlserverfqdn" {
  value = "azurerm_mssql_server.sqlserver.fully_qualified_domain_name"
  sensitive = true
}

output "sqlconnectionstring" {
  value = "Server=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.adsync.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${azurerm_mssql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive = true
}

output "adminlogin" {
  value = "azurerm_mssql_server.sqlserver.administrator_login"
  sensitive = true
}

output "adminpassword" {
  value = "azurerm_mssql_server.sqlserver.administrator_login_password"
  sensitive = true
}