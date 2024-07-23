variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "private_ip" {
  description = "value of private ip"
  type        = string
}

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

variable "local_admin_password" {
  type        = string
  description = "The password of the local administrator account."
}

variable "runnumber" {
  description = "The run number"
  type        = string
}

variable "adou_suffix" {
  type        = string
  description = "The suffix of Active Directory OU path."
  default     = "DC=jumpstart,DC=local"
}
