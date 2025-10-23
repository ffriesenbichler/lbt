# Pool
resource "libvirt_volume" "default" {
  name = var.lbt-env.pool_name
}

# Disks
resource "libvirt_volume" "debian_base" {
  name   = "debian-base"
  source = var.debian_13_img
  pool   = var.lbt-env.pool_name
  format = "qcow2"
}

resource "libvirt_volume" "winSrv_base" {
  name   = "winSrv-base"
  source = var.winSrv_22_img
  pool   = var.lbt-env.pool_name
  format = "qcow2"
}

resource "libvirt_volume" "winClt_base" {
  name   = "winClt-base"
  source = var.winClt_10_img
  pool   = var.lbt-env.pool_name
  format = "qcow2"
}
