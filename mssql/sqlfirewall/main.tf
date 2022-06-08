module "sqlserverid" {
    source = "github.com/DubberSoftware/dubber-terraform-modules/tree/master/msteams-ad-sync/modules/mssql"
}

resource "azurerm_mssql_firewall_rule" "adsync-firewall-1" {
  name             = "adsync-firewall"
  server_id        = module.sqlserverid.sqlserverid
  start_ip_address = var.aks_nat_ip1
  end_ip_address   = var.aks_nat_ip2
}