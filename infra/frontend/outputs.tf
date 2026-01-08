output "storage_static_website_endpoint" {
  value       = azurerm_storage_account.sa.primary_web_endpoint
  description = "Direct Storage static website endpoint"
}

output "frontdoor_default_hostname" {
  value       = azurerm_cdn_frontdoor_endpoint.fd_endpoint.host_name
  description = "Front Door default hostname"
}

output "frontdoor_custom_domain_validation_token" {
  value       = var.custom_domain_hostname == null ? null : azurerm_cdn_frontdoor_custom_domain.custom_domain[0].validation_token
  description = "DNS TXT validation token for Front Door custom domain"
}
