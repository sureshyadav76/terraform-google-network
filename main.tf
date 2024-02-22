data "google_client_config" "current" {
}

module "labels" {
  source      = "sureshyadav76/labels/google"
  version     = "1.0.1"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}

resource "google_compute_network" "vpc" {
  count                                     = var.network_enabled && var.module_enabled ? 1 : 0
  project                                   = data.google_client_config.current.project
  name                                      = format("%s-vpc", module.labels.id)
  description                               = var.description
  routing_mode                              = var.routing_mode
  mtu                                       = var.mtu
  auto_create_subnetworks                   = var.auto_create_subnetworks
  enable_ula_internal_ipv6                  = var.enable_ula_internal_ipv6
  internal_ipv6_range                       = var.internal_ipv6_range
  delete_default_routes_on_create           = var.delete_default_routes_on_create
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
}
