variable "debian_13_img" {
  default = "../img/debian_13.qcow2"
}

variable "winSrv_22_img" {
  default = "../img/winSrv_22.iso"
}

variable "winClt_10_img" {
  default = "../img/winClt_10.iso"
}

variable "ssh_pub_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "debian_13_cloud_config" {
  default = "./config/debian/cloud-config.yaml"
}

variable "winSrv_22_cloud_config" {
  default = "./config/windows/srv/cloud-config.yaml"
}

variable "winClt_10_cloud_config" {
  default = "./config/windows/clt/cloud-config.yaml"
}

variable "lbt_env" {
  default = {
    pool_name = "lbt-pool"
    pool_path = "/var/lib/libvirt/images/lbt"
  }
}
