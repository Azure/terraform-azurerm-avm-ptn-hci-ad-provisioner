mock_provider "azapi" {
  mock_data "azapi_client_config" {
    defaults = {
      subscription_id          = "00000000-0000-0000-0000-000000000001"
      subscription_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000001"
      tenant_id                = "00000000-0000-0000-0000-000000000002"
    }
  }
}


variables {
  adou_path                = "OU=test,DC=example,DC=com"
  dc_ip                    = "192.0.2.1"
  deployment_user          = "testuser"
  deployment_user_password = "test-only"
  domain_admin_password    = "test-only"
  domain_admin_user        = "testadmin"
  domain_fqdn              = "example.com"
  resource_group_name      = "test-rg"
}

run "telemetry_enabled_with_location" {
  command = plan

  variables {
    enable_telemetry = true
    location         = "eastus"
  }

  assert {
    condition     = local.main_location == "eastus" && length(data.azapi_client_config.telemetry) == 1
    error_message = "Enabled telemetry must use the supplied location and client configuration."
  }
}

run "telemetry_enabled_without_location" {
  command = plan

  variables {
    enable_telemetry = true
    location         = null
  }

  expect_failures = [var.location]
}

run "telemetry_disabled_without_location" {
  command = plan

  variables {
    enable_telemetry = false
    location         = null
  }

  assert {
    condition     = var.location == null && length(data.azapi_client_config.telemetry) == 0
    error_message = "Disabled telemetry must accept a null location without a telemetry client."
  }
}
