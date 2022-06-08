module "redisrg" {
  source = "github.com/karthikshekar23/Terraformtest/tree/master/ResourceGroups"
}

resource "azurerm_redis_cache" "redis" {
  name                = "${var.prefix}-ad-sync-redis"
  location            = module.redisrg.redisrg.location
  resource_group_name = module.redisrg.redisrg.name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.tier
  enable_non_ssl_port = false
  redis_configuration {
    notify_keyspace_events = "KEx"
  }
}

resource "azurerm_redis_firewall_rule" "redis-firewall-1" {
  name                = "${var.prefix}_ad_sync_redis_firewall_1"
  redis_cache_name    = azurerm_redis_cache.redis_name
  resource_group_name = module.redisrg.redisrg
  start_ip            = var.aks_nat_ip1
  end_ip              = var.aks_nat_ip2
}

output "redis_name" {
  value = azurerm_redis_cache.redis.name
  sensitive = true
}

output "redis_id" {
  value = azurerm_redis_cache.redis.id
  sensitive = true
}

output "redisconnection" {
  value = azurerm_redis_cache.redis.primary_connection_string
  sensitive = true
}

output "redissecondaryconnection" {
  value = azurerm_redis_cache.redis.secondary_connection_string
  sensitive = true
}
