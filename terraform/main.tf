# Storage Pool
resource "libvirt_pool" "lbt_volume" {
  name = var.lbt_env.pool_name
  type = "dir"
  target {
    path = var.lbt_env.pool_path
  }
}

# Disks
resource "libvirt_volume" "debian_base" {
  name   = "debian-base"
  source = var.debian_13_img
  pool   = libvirt_pool.lbt_volume.name
  format = "qcow2"
}

resource "libvirt_volume" "winSrv_base" {
  name   = "winSrv-base"
  source = var.winSrv_22_img
  pool   = libvirt_pool.lbt_volume.name
  format = "qcow2"
}

resource "libvirt_volume" "winClt_base" {
  name   = "winClt-base"
  source = var.winClt_10_img
  pool   = libvirt_pool.lbt_volume.name
  format = "qcow2"
}
