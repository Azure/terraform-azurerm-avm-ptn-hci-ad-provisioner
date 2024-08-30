terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

# This is required for resource modules
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "test" {
  source = "../../"
  # source             = "Azure/avm-ptn-hci-ad-provisioner/azurerm"
  # ...
  resource_group_name = data.azurerm_resource_group.rg.name

  enable_telemetry = var.enable_telemetry # see variables.tf
  # Beginning of specific varible for virtual environment
  dc_port                  = 6985
  dc_ip                    = var.dc_ip
  authentication_method    = "Credssp"
  domain_fqdn              = "jumpstart.local"
  deployment_user_password = var.deployment_user_password
  domain_admin_user        = var.domain_admin_user
  domain_admin_password    = var.domain_admin_password
  deployment_user          = var.deployment_user
  adou_path                = local.adou_path
}
