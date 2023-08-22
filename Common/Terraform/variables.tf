variable "resource_group_name" {
  type    = string  
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS" 
}

variable "app_service_plan_name" {
  type    = string  
}

variable "app_service_plan_tier" {
  type    = string  
}

variable "app_service_plan_size" {
  type    = string  
}

variable "function_app_name" {
  description = "Function App name"
  type        = string
}

/*** variable "app_configuration_name" {
  description = "App Configuration name"
  type        = string
} ***/



