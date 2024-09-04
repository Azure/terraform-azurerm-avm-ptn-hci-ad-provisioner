resource "terraform_data" "replacement" {
  input = var.resource_group_name
}

# this is following https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-tool-active-directory
resource "terraform_data" "ad_creation_provisioner" {
  provisioner "local-exec" {
    command     = "powershell.exe -ExecutionPolicy Bypass -NoProfile -File ${path.module}/ad.ps1 -userName ${var.domain_admin_user} -password \"${var.domain_admin_password}\" -authType ${var.authentication_method} -ip ${var.dc_ip} -port ${var.dc_port} -adouPath ${var.adou_path} -domainFqdn ${var.domain_fqdn} -ifdeleteadou ${var.destory_adou} -deploymentUser ${var.deployment_user} -deploymentUserPassword \"${var.deployment_user_password}\""
    interpreter = ["PowerShell", "-Command"]
  }

  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
