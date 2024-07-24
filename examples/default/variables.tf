variable "deployment_user_password" {
  type        = string
  description = "The password for deployment user."
}

variable "domain_admin_password" {
  type        = string
  description = "The password of the domain account."
}

variable "domain_admin_user" {
  type        = string
  description = "The username of the domain account."
}

variable "private_ip" {
  type        = string
  description = "value of private ip"
}

variable "runnumber" {
  type        = string
  description = "The run number"
}

variable "adou_suffix" {
  type        = string
  default     = "DC=jumpstart,DC=local"
  description = "The suffix of Active Directory OU path."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}
