resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = true
}

resource "azurerm_storage_account_static_website" "static" {
  storage_account_id = azurerm_storage_account.sa.id
  index_document     = var.index_document
  error_404_document = var.error_document
}

resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.frontdoor_profile_name
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                    = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

resource "azurerm_cdn_frontdoor_origin_group" "og" {
  name                    = "og-static-site"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id

  health_probe {
    interval_in_seconds = 120
    path                = "/"
    protocol            = "Https"
    request_type        = "GET"
  }

  load_balancing {
    sample_size                = 4
    successful_samples_required = 3
    additional_latency_in_milliseconds = 0
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  name                          = "origin-static-site"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og.id

  host_name          = azurerm_storage_account.sa.primary_web_host
  origin_host_header = azurerm_storage_account.sa.primary_web_host

  http_port  = 80
  https_port = 443

  enabled                       = true
  certificate_name_check_enabled = true

  priority = 1
  weight   = 1000
}

resource "azurerm_cdn_frontdoor_route" "route" {
  name                          = "route-static-site"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin.id]

  enabled                = true
  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  link_to_default_domain = true
}

resource "azurerm_cdn_frontdoor_custom_domain" "custom_domain" {
  count = var.custom_domain_hostname == null ? 0 : 1

  name                     = "cd-${replace(var.custom_domain_hostname, ".", "-")}"
  cdn_frontdoor_profile_id  = azurerm_cdn_frontdoor_profile.fd_profile.id
  host_name                = var.custom_domain_hostname

  tls {
    certificate_type = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "custom_domain_assoc" {
  count = var.custom_domain_hostname == null ? 0 : 1

  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.custom_domain[0].id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.route.id]
}
