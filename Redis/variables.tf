variable "prefix" {
  description = "Env prefix"
  default = "dev"
}

variable "capacity" {
  description = "Capacity of redis"
  default = 0
}

variable "family" {
  description = "Family of azure cache"
  default = "C"
}

variable "tier" {
  description = "Tier of azure cache"
  default = "Standard"
}

variable "aks_nat_ip1" {
  description = "AKS nat IP1"
  default = "40.82.201.208"
}

variable "aks_nat_ip2" {
  description = "AKS nat IP2"
  default = "40.82.201.218"
}
