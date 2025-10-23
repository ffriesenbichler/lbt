#output "ubuntu_ip" {
#  value = libvirt_domain.ubuntu.network_interface[0].addresses[0]
#}

#output "windows_ip" {
#  value = libvirt_domain.windows.network_interface[0].addresses[0]
#}

#output "spice_ports" {
#  value = {
#    ubuntu  = libvirt_domain.windows.graphics[0].port
#    windows = libvirt_domain.windows.graphics[0].port
#  }
#}
