data "template_file" "user_data" {
  for_each = var.vms

  template = file("${path.module}/config/cloud-init.tpl.yml")

  vars = {
    vm_hostname   = each.value.vm_hostname
    domain        = var.network_config.domain
    root_password = var.root_password
    ssh_keys      = join("\n - ", var.ssh_keys)
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/config/network_config.yml")
}

# Disks
resource "libvirt_volume" "debian_base" {
  name   = "debian-base"
  source = var.debian_13_img_url
  pool   = "default"
  format = "qcow2"
}

resource "libvirt_volume" "vm_disks" {
  for_each = var.vms

  name           = "${each.key}-debian-disk.qcow2"
  base_volume_id = libvirt_volume.debian_base.id
  pool           = "default"
  size           = each.value.disk * 1024 * 1024 * 1024
}

# VM Commoninit
resource "libvirt_cloudinit_disk" "commoninit" {
  for_each = var.vms

  name           = "${each.key}-commoninit.iso"
  user_data      = data.template_file.user_data[each.key].rendered
  network_config = data.template_file.network_config.rendered
}

# VM Domains
resource "libvirt_domain" "domain_debian" {
  for_each = var.vms

  name   = each.value.vm_hostname
  memory = each.value.memory * 1024
  vcpu   = each.value.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[each.key].id
  dynamic "network_interface" {
    for_each = each.value.networks
    content {
      network_name   = network_interface.value.network_name
      wait_for_lease = true
      mac            = lookup(network_interface.value, "mac", null)
      bridge         = lookup(network_interface.value, "bridge", null)
      hostname       = each.value.vm_hostname
    }
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.vm_disks[each.key].id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
