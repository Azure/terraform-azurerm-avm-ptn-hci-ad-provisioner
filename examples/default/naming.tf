locals {
  adou_path           = "OU=${local.site_id},${var.adou_suffix}"
  deployment_user     = "${local.site_id}deploy"
  resource_group_name = "${local.site_id}-rg"
  site_id             = "avm${var.runnumber}"
}
