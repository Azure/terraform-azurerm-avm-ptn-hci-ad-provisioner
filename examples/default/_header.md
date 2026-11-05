# Default example

This example prepares Active Directory objects in an existing HCI lab. It does not create a domain controller or resource group.

## Prerequisites

Use an existing non-production `jumpstart.local` domain with a domain controller reachable over WinRM on port `6985` using CredSSP. Applying the example requires an approved Windows runner and a domain account authorized to prepare the HCI AD objects. The script changes the runner's WinRM/CredSSP settings and installs `AsHciADArtifactsPreCreationTool` on the domain controller from PowerShell Gallery.

Authenticate to Azure with an approved identity for the subscription in the supplied resource group ID. Supply the group's actual region. The example does not look up or verify the group.

## Required lab inputs

Supply real fixture values through these exact Terraform environment names. Keep both passwords in Actions secrets.

| Terraform environment name | Actions setting to map | Required value |
| --- | --- | --- |
| `TF_VAR_dc_ip` | `TF_VAR_DC_IP` | Existing lab domain-controller address |
| `TF_VAR_deployment_user_password` | `TF_VAR_DEPLOYMENT_USER_PASSWORD` (secret) | Deployment-user password meeting the domain policy |
| `TF_VAR_domain_admin_password` | `TF_VAR_DOMAIN_ADMIN_PASSWORD` (secret) | Password for the authorized domain account |
| `TF_VAR_domain_admin_user` | `TF_VAR_DOMAIN_ADMIN_USER` | Authorized domain-account username |
| `TF_VAR_resource_group_id` | `TF_VAR_RESOURCE_GROUP_ID` | Resource ID of the existing group in the lab subscription |
| `TF_VAR_location` | `TF_VAR_LOCATION` | The existing group's Azure region |

GitHub stores Actions setting names in uppercase, but Terraform input names are case-sensitive on Linux. For deployments, explicitly map each setting above to its lowercase-suffix Terraform environment name in the process running `Avm.Authoring`.

For the managed PR-check policy plan only, `pre.ps1` supplies missing inputs using a synthetic group ID in the selected subscription, a region, and non-secret provisioner placeholders. Supplied values take precedence. The hook writes only inside the isolated policy stage and does not supply deployment inputs or create a group.

Do not commit lab values or print passwords. The default deployment user is `avmdeploy`, and the AD OU path is `OU=<resource_group_name>,DC=jumpstart,DC=local`.
