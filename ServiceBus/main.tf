resource "azurerm_servicebus_namespace" "adsync" {
  name                = "${var.prefix}-adsync-servicebus-namespace"
  location            = azurerm_resource_group.servicebus.location
  resource_group_name = azurerm_resource_group.servicebus.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "adsync-queue" {
  name         = "adsync_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.adsync.id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue_authorization_rule" "adsync" {
  name     = "adsync-send-listen"
  queue_id = azurerm_servicebus_queue.adsync-queue.id

  listen = true
  send   = true
  manage = false
}

output "queueauthorization" {
  value = "azurerm_servicebus_queue_authorization_rule.adsync.primary_connection_string"
  sensitive = true
}



