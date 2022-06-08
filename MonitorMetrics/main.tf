module "redisrg" {
  source = "github.com/karthikshekar23/Terraformtest/tree/master/ResourceGroups"
}

module "redis_id" {
  source = "github.com/karthikshekar23/Terraformtest/tree/master/Redis"
}

resource "azurerm_monitor_metric_alert" "memory_warning" {
  name                = "${var.prefix}-ad-sync-redis-memory-warning"
  resource_group_name = module.redisrg.redisrg
  scopes              = [module.redis_id.redis_id]
  description         = "Redis memory usage is greater than a given threshold."

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "allusedmemorypercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.memory_warning_threshold
  }

  frequency          = var.alert_frequency
  window_size        = var.alert_window
  severity           = 3
  auto_mitigate      = true

  action {
    action_group_id = azurerm_monitor_action_group.memory_warning_resolver.id
  }
}

resource "azurerm_monitor_action_group" "memory_warning_resolver" {
  name                = "memory_warning_resolver_action_group"
  resource_group_name = module.redisrg.redisrg
  short_name          = "${var.prefix}memwarn"

  webhook_receiver {
    name        = "memory_warning_receiver"
    service_uri = var.warning_receiver_uri
  }
}

resource "azurerm_monitor_metric_alert" "memory_alert" {
  name                = "${var.prefix}-ad-sync-redis-memory-alert"
  resource_group_name = module.redisrg.redisrg
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Redis memory usage is greater than a given threshold."

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "allusedmemorypercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.memory_alert_threshold
  }

  frequency          = var.alert_frequency
  window_size        = var.alert_window
  severity           = 3
  auto_mitigate      = true

  action {
    action_group_id = azurerm_monitor_action_group.memory_alert_resolver.id
  }
}

resource "azurerm_monitor_action_group" "memory_alert_resolver" {
  name                = "memory_alert_resolver_action_group"
  resource_group_name = module.redisrg.redisrg
  short_name          = "${var.prefix}memalert"

  webhook_receiver {
    name        = "memory_alert_receiver"
    service_uri = var.alert_receiver_uri
  }
}

resource "azurerm_monitor_metric_alert" "cpu_warning" {
  name                = "${var.prefix}-ad-sync-redis-cpu-warning"
  resource_group_name = module.redisrg.redisrg
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Redis CPU usage is greater than a given threshold."

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "percentProcessorTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_warning_threshold
  }

  frequency          = var.alert_frequency
  window_size        = var.alert_window
  severity           = 3
  auto_mitigate      = true

  action {
    action_group_id = azurerm_monitor_action_group.cpu_warning_resolver.id
  }
}

resource "azurerm_monitor_action_group" "cpu_warning_resolver" {
  name                = "cpu_warning_resolver_actiongroup"
  resource_group_name = module.redisrg.redisrg
  short_name          = "${var.prefix}cpuwarn"

  webhook_receiver {
    name        = "cpu_warning_receiver"
    service_uri = var.warning_receiver_uri
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "${var.prefix}-ad-sync-redis-cpu-alert"
  resource_group_name = module.redisrg.redisrg
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Redis CPU usage is greater than a given threshold."

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "percentProcessorTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_alert_threshold
  }

  frequency          = var.alert_frequency
  window_size        = var.alert_window
  severity           = 3
  auto_mitigate      = true

  action {
    action_group_id = azurerm_monitor_action_group.cpu_alert_resolver.id
  }
}

resource "azurerm_monitor_action_group" "cpu_alert_resolver" {
  name                = "cpu_alert_resolver_action_group"
  resource_group_name = module.redisrg.redisrg
  short_name          = "${var.prefix}cpualert"

  webhook_receiver {
    name        = "cpu_alert_receiver"
    service_uri = var.alert_receiver_uri
  }
}

