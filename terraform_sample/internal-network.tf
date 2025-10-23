resource "libvirt_network" "internal" {
  name      = var.network_config.name
  autostart = var.network_config.autostart
  mode      = var.network_config.mode
  domain    = var.network_config.domain
  addresses = var.network_config.addresses

  dns {
    enabled    = true
    local_only = true
    dynamic "hosts" {
      for_each = var.network_config.dns_hosts
      content {
        hostname = hosts.value.hostname
        ip       = hosts.value.ip
      }
    }
  }
}
