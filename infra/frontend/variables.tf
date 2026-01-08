variable "location" {
  type        = string
  description = "Azure region"
  default     = "norwayeast"
}

variable "resource_group_name" {
  type        = string
  description = "Frontend resource group name"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name (3-24 lowercase letters/numbers)"
}

variable "index_document" {
  type        = string
  default     = "index.html"
}

variable "error_document" {
  type        = string
  default     = null
  description = "Optional 404 document. Set null if not used."
}

variable "frontdoor_profile_name" {
  type        = string
  description = "Front Door profile name"
}

variable "frontdoor_endpoint_name" {
  type        = string
  description = "Front Door endpoint name"
}

variable "custom_domain_hostname" {
  type        = string
  default     = null
  description = "Optional custom domain hostname, e.g. www.example.com. If null, only the default Front Door hostname is used."
}
