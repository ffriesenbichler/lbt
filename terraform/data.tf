data "cloudinit_config" "debian_13_cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/${var.debian_13_cloud_config}")
  }
}

data "cloudinit_config" "winSrv_22_cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/${var.winSrv_22_cloud_config}")
  }
}

data "cloudinit_config" "winClt_10_cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/${var.winClt_10_cloud_config}")
  }
}
