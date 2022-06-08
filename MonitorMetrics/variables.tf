variable "prefix" {
  description = "Env prefix"
  default = "dev"
}

variable "memory_warning_threshold" {
  description = "Memory usage warning threshold"
  default = 70
}

variable warning_receiver_uri {
  default = "https://prod-18.australiaeast.logic.azure.com:443/workflows/a9edc4219653492eae1b7bdd29209125/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=NuD0HElx0qio-3RcLNJBV5YqfJs8pc7Sb9y-tk1FdY4"
}

variable "memory_alert_threshold" {
  description = "Memory usage alert threshold"
  default = 80
}

variable alert_frequency {
  default = "PT5M"
}

variable alert_window {
  default = "PT15M"
}

variable alert_receiver_uri {
  default = "https://events.pagerduty.com/integration/b408d7e071624af787b244c83997a32b/enqueue"
}

variable "cpu_warning_threshold" {
  description = "CPU usage warning threshold"
  default = 70
}


