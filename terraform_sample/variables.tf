variable "debian_13_img_url" {
  description = "Path or URL to the Debian image"
  default     = "https://cdimage.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
}

variable "ms_srv_22_img" {
  description = "Path to the Windows Server image"
  default = "~/"
}

variable "ssh_keys" {
  description = "List of authorized SSH public keys"
  type        = list(string)
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6rFT1T4DKDOGyWjGzHM2rjT8+3Le4TdTO6EMsMW2uakImQG8G7XHBfCBOuHk5+7b7Se9NOuPoSG1EMnmPrs3GhTNF/jIRF66NH6WIKtbl3LzI+JRU58zY58hNkKBoGIkCiViyLvAN6iQsSX0Hm6Ll7nsS2of8ZUTtxalByAxNmF1KPhQKk7cb8OX1Qla+Jz65yCO0VrWpralFx/Rv1d0pUImRtUY3kHquqhQpQGV443SHnRdBpe3Nf1zlVzQg+Dasz2AuVq8C5Hc0v8Ca6+8hr9OZDCFMKkvtHLA13Z1iIdUWb2gqYCrY++kIb6ataGjSSQ8Fe1AF4Jc5rjDsZ0LV3xLH/Ddlo6g2WmwCxBHPXMznxbJJ7Yd0qvXylhXq65EBzmLhlzME1dlb5u94lUZAvy2uo4l++JJlZf1W/lqAYI68GDp50bs7jm5ydDkDeZUZGgx/WvzIy7UZy0wMJAIOm9+ct2E01tejs0R84M34axhw5uZULRJyIVQ8xhcM9+4jE8jJut7vqin2t5c4q/YkmahZsuhleZZTRRSSydl+J/ufBpO0M5wKzx3LWrTZ2kHxaMqn0ejWHOq2y25HD/wODgqYXsIYen58XVuipr9Bb9v/aSvCnmexcful/IdsypAo61tq4G6JfPWi3uessOjr+sqE3qwyG5oJwjBorXZd7w== mogor@modul"
  ]
}

variable "root_password" {
  description = "Root password for VMs"
  type        = string
  default     = "root"
  sensitive   = true
}

variable "network_config" {
  description = "Configuration for the libvirt network"
  type = object({
    name      = string
    autostart = bool
    mode      = string
    domain    = string
    addresses = list(string)
    dns_hosts = list(object({
      hostname = string
      ip       = string
    }))
  })
  default = {
    name      = "internal"
    autostart = true
    mode      = "none"
    domain    = "goofy.net"
    addresses = ["172.16.15.0/24"]
    dns_hosts = [
      { hostname = "bemula", ip = "85.85.85.85" },
      { hostname = "web1", ip = "10.198.12.10" },
      { hostname = "web2", ip = "10.198.12.11" },
      { hostname = "test", ip = "10.198.12.11" }
    ]
  }
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    vm_hostname = string
    memory      = number #GB
    vcpu        = number
    disk        = number #GB
    networks = list(object({
      network_name = string
      mac          = optional(string)
      bridge       = optional(string)
    }))
  }))
  default = {
    "vm1" = {
      vm_hostname = "vm1"
      memory      = 1
      vcpu        = 1
      disk        = 15
      networks = [
        { network_name = "internal" },
        { network_name = "default" }
      ]
    },
    "vm2" = {
      vm_hostname = "vm2"
      memory      = 1
      vcpu        = 1
      disk        = 15
      networks = [
        { network_name = "internal" }
      ]
    },
    "vm3" = {
      vm_hostname = "vm3"
      memory      = 1
      vcpu        = 1
      disk        = 15
      networks = [
        { network_name = "internal" }
      ]
    },
  }
}
