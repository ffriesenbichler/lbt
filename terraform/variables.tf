variable "debian_13_img" {
  default = "./debian_13.qcow2"
}

variable "winSrv_22_img" {
  default = "./winSrv_22.qcow2"
}

variable "winClt_10_img" {
  default = "./winClt_10_img"
}

variable "ssh_pub_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "debian_13_cloud_config" {
  default = "./config/debian/cloud-config-yaml"
}

variable "winSrv_22_cloud_config" {
  default = "./config/windows/srv/cloud-config.yaml"
}

variable "winClt_10_cloud_config" {
  default = "./config/windows/clt/cloud-config.yaml"
}

variable "lbt-env" {
  default = {
    pool_name = "lbt-pool"
  }
}