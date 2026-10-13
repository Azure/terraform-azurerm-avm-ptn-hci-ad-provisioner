# Default example

This example prepares Active Directory objects in an existing HCI lab. It does not create a domain controller or resource group.

## Prerequisites

Use an existing non-production `jumpstart.local` domain with a domain controller reachable over WinRM on port `6985` using CredSSP. Applying the example requires an approved Windows runner and a domain account authorized to prepare the HCI AD objects. The script changes the runner's WinRM/CredSSP settings and installs `AsHciADArtifactsPreCreationTool` on the domain controller from PowerShell Gallery.

Authenticate to Azure with the approved identity and set `ARM_SUBSCRIPTION_ID` to the subscription containing the existing resource group. The identity must be able to read that group. Managed CI supplies its selected subscription through this environment variable; any `ARM_SUBSCRIPTION_ID_OVERRIDE` must belong to the permitted CI subscription pool.

## Required lab inputs

Supply real fixture values through these exact Terraform environment names. Keep both passwords in Actions secrets.

| Terraform environment name | Actions setting to map | Required value |
| --- | --- | --- |
| `TF_VAR_dc_ip` | `TF_VAR_DC_IP` | Existing lab domain-controller address |
| `TF_VAR_deployment_user_password` | `TF_VAR_DEPLOYMENT_USER_PASSWORD` (secret) | Deployment-user password meeting the domain policy |
| `TF_VAR_domain_admin_password` | `TF_VAR_DOMAIN_ADMIN_PASSWORD` (secret) | Password for the authorized domain account |
| `TF_VAR_domain_admin_user` | `TF_VAR_DOMAIN_ADMIN_USER` | Authorized domain-account username |
| `TF_VAR_resource_group_name` | `TF_VAR_RESOURCE_GROUP_NAME` | Existing resource group in the selected subscription |

GitHub stores Actions setting names in uppercase, but Terraform input names are case-sensitive on Linux. The managed workflow exports stored names unchanged: explicitly map each setting above to its lowercase-suffix Terraform environment name in the process running `Avm.Authoring`. A per-example `pre.ps1` hook must instead write those exact names to `.env`, because its process environment is not inherited by Terraform.

No fixture values or input hook are provided by this example. Do not commit lab values or print passwords. The default deployment user is `avmdeploy`, and the AD OU path is `OU=<resource_group_name>,DC=jumpstart,DC=local`.
