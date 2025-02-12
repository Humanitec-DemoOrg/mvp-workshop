
# MVP Workshop - Day 3 - As Platform Engineer,

- Golden path PE-5: I want to allow my Devs to use Azure Blob Storage with their Workloads
  - Define an `azure-blob` (`echo`)
  - Define an `azure-blob` (`terraform`) inline
  - Define an `azure-blob` (`terraform`) in git
- Golden path PE-6: I want to allow my Devs to generate an Azure Service Principal for their Workloads
  - Define an `azure-service-principal` (`echo`)
- Next steps

## Golden path PE-5: I want to allow my Devs to use Azure Blob Storage with their Workloads

### Define an `azure-blob` (`echo`)

On the UI, create new "Azure Blob Storage" resource definition as `echo` with these values:
- ID: `azure-blob-echo`
- Azure Blob Storage Account Name: `echo-account-name`
- Azure Blob Storage Container Name: `echo-container-name`

Add Matching criteria: `class: default`.

You Developers can now use it:
```bash
humctl score available-resource-types
```

### Define an `azure-blob` (`terraform`) inline

On the UI, create new "Azure Blob Storage" resource definition as `terraform` with these values:
- ID: `azure-blob-tf`
- Custom Script:
```terraform
terraform {
}
output "account" {
  value = "hard-coded-account"
}
output "container" {
  value = "hard-coded-container"
}
```

Add Matching criteria: `class: YOUR-APP`.

### Define an `azure-blob` (`terraform`) in git

On the UI, update the existing `azure-blob-tf` resource definition:
- Custom Script: Empty it.
- Git Source:
  - URL: `https://github.com/Humanitec-DemoOrg/mvp-workshop.git`
  - Revision: `refs/heads/main`
  - Sub path: `tf-modules/azure-blob-echo`

## Golden path PE-6: I want to allow my Devs to generate an Azure Service Principal for their Workloads

### Define an `azure-service-principal` (`echo`)

On the UI, create new "Azure Service Principal" resource definition as `echo` with these values:
- ID: `azure-sp-echo`
- Password: `echo-password`
- Application (client) ID: `echo-client-id`
- Directory (tenant) ID: `echo-tenant-id`

Add Matching criteria: `class: default`.

You Developers can now use it:
```bash
humctl score available-resource-types
```

## Next steps

- Private Git repo for TF Modules
- TF runner in your own Kubernetes cluster
- Container runner in your own Kubernetes cluster
- Add `redis` with `template` (in-cluster) and `terraform` (in Azure)