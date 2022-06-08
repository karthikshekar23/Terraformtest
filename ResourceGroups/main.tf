resource "azurerm_resource_group" "redis" {
  name     = "${var.prefix}-ad-sync-redis"
  location = var.location
}

resource "azurerm_resource_group" "sql" {
  name     = "${var.prefix}-ad-sync-sql"
  location = var.location
}

resource "azurerm_resource_group" "servicebus" {
  name     = "${var.prefix}-ad-sync-servicebus"
  location = var.location
}


output "redisrg" {
  value = "azurerm_resource_group.redis.name"
  sensitive = true
}

output "sqlrg" {
  value = "azurerm_resource_group.sql.name"
  sensitive = true
}

output "sqlrgloc" {
  value = "azurerm_resource_group.sql.location"
  sensitive = true
}

output "servicebusrg" {
  value = "azurerm_resource_group.servicebus.name"
  sensitive = true
}