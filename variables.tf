variable "adou_path" {
  type        = string
  description = "The Active Directory OU path."
}

variable "dc_ip" {
  type        = string
  description = "The ip of the server."
}

variable "deployment_user" {
  type        = string
  description = "The username for deployment user."

  validation {
    condition     = length(var.deployment_user) < 21 && length(var.deployment_user) > 0 && can(regex("^[a-zA-Z_][a-zA-Z0-9_-]*$", var.deployment_user))
    error_message = "Username must be between 1 to 20 characters and only contain letters, numbers, hyphens, and underscores and may not start with a hyphen or number."
    # 20 character limit for sAMAccountName in ad preparation New-ADUser.
  }
}

variable "deployment_user_password" {
  type        = string
  description = "The password for deployment user."
  sensitive   = true
}

variable "domain_admin_password" {
  type        = string
  description = "The password for the domain administrator account."
  sensitive   = true
}

variable "domain_admin_user" {
  type        = string
  description = "The username for the domain administrator account."
}

variable "domain_fqdn" {
  type        = string
  description = "The domain FQDN."
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "authentication_method" {
  type        = string
  default     = "Default"
  description = "The authentication method for Enter-PSSession."

  validation {
    condition     = can(regex("^(Default|Basic|Negotiate|NegotiateWithImplicitCredential|Credssp|Digest|Kerberos)$", var.authentication_method))
    error_message = "Value of authentication_method should be {Default | Basic | Negotiate | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}"
  }
}

variable "dc_port" {
  type        = number
  default     = 5985
  description = "Domain controller winrm port in virtual host"
}

variable "destory_adou" {
  type        = bool
  default     = false
  description = "whether destroy previous adou"
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}
