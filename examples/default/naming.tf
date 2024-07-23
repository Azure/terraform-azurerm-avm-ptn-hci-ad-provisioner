locals {
  adou_path       = "OU=${local.site_id},${var.adou_suffix}"
  deployment_user = "${local.site_id}deploy"
  site_id         = "iac${var.runnumber}"
}
