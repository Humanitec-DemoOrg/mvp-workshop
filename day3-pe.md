
# MVP Workshop - Day 3 - As Platform Engineer,

- Golden path PE-5: I want to allow my Devs to use Azure Blob Storage with their Workloads
  - Define an `azure-blob` (`echo`)
  - Define an `azure-blob` (`terraform`) inline
  - Define an `azure-blob` (`terraform`) in public git
  - Define an `azure-blob` (`terraform`) with Cloud Account injected
  - Define an `azure-blob` (`terraform`) in private git
- Golden path PE-6: I want to allow my Devs to generate an Azure Service Principal for their Workloads
  - Define an `azure-service-principal` (`echo`)
- Next steps

## Golden path PE-5: I want to allow my Devs to use Azure Blob Storage with their Workloads

You Developers has currently access to:
```bash
humctl score available-resource-types
```

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

### Define an `azure-blob` (`terraform`) in public git

On the UI, update the existing `azure-blob-tf` resource definition:
- Custom Script: Empty it.
- Git Source:
  - URL: `https://github.com/Humanitec-DemoOrg/mvp-workshop.git`
  - Revision: `refs/heads/main`
  - Sub path: `tf-modules/azure-blob-echo`

### Define an `azure-blob` (`terraform`) with Cloud Account injected

On the UI, update the existing `azure-blob-tf` resource definition:
- Cloud Account: Select.
- Git Source:
  - URL: `https://github.com/Humanitec-DemoOrg/mvp-workshop.git`
  - Revision: `refs/heads/main`
  - Sub path: `tf-modules/azure-blob-echo-cloud-account`

### Define an `azure-blob` (`terraform`) in private git

In your secret store, see which one you have configured so far:
```bash
humctl api get /orgs/${HUMANITEC_ORG}/secretstores
```

Create a new secret to store either the SSH key or Token to access your private Git repo where your own Terrafrom Modules are.

And then create the associated `azure-blob` resource definition via the `humctl` CLI (not UI) this time, `azure-blob-tf.yaml`:
```yaml
apiVersion: entity.humanitec.io/v1b1
kind: Definition
metadata:
  id: azure-blob-tf
entity:
  driver_type: humanitec/terraform
  name: azure-blob-tf
  type: azure-blob
  driver_account: FIXME-CLOUD_ACCOUNT_ID
  driver_inputs:
    values:
      append_logs_to_error: true
      source:
        path: tf-modules/azure-blob-full
        rev: refs/heads/main
        url: https://github.com/Humanitec-DemoOrg/mvp-workshop.git
      credentials_config:
        variables:
          oidc_token: oidc_token
      variables:
        tenant_id: FIXME-AZURE_TENANT_ID
        subscription_id: FIXME-AZURE_SUBSCRIPTION_ID
        client_id: FIXME-MANAGED_IDENTITY_CLIENT_ID
        resource_group_name: FIXME-AZURE_RESOURCE_GROUP
  criteria:
    - {}
```
Change all the `FIXME-*` accordingly:
- `FIXME-CLOUD_ACCOUNT_ID`: the `id` of the Cloud Account you created previously (`humctl api get /orgs/${HUMANITEC_ORG}/resources/accounts`).
- `FIXME-MANAGED_IDENTITY_CLIENT_ID`: the Client ID associated to Managed Identity of the Cloud Account above.
- `FIXME-AZURE_TENANT_ID`: where the Managed Identity of the Cloud Account has been created.
- `FIXME-AZURE_SUBSCRIPTION_ID`: the Azure Subscription ID where the Azure Blob will be created.
- `FIXME-AZURE_RESOURCE_GROUP`: the Azure Resource Group where the Azure Blob will be created.

Important notes:
- At this stage, the Terraform Runner and Terraform State are still managed/hosted in Humanitec, not yet in your own infrastructure. This will be the next step once this has been deployed/tested successfully first.
- In the `variables` section, values are hard-coded for now, we'll discuss later how to dynamically inject them based on more context (`app_id`, `env_id`, etc.). You will also need to add more `variables` that your own Terraform Module requires. Again, you can "hard-code" these values for now, we'll discuss later about how to dynamically inject them based on context.
- You need to change the `source.path|url` according to your own private Git repo. For the `url` it's `https://...` if you go with `token`, otherwise it's `git@...` with `ssh_key`. This also assumes that your private Git repo is accessible from the Humanitec SaaS (not behind internal networking).
- Your Terraform module needs to accept (or be adapted) the `variables` described here, you can see an example [here](./tf-modules/azure-blob-full/main.tf). If you don't want to edit directly your currrent Terraform Module, you can create a new Terraform Module acting as a wrapper between the resource definition and your actual Terraform Module.
- You need to grant the associated Azure Roles to the Managed Identity of the Cloud Account used above to properly provisioned the Azure Blob and associated Azure services your Terraform Module requires. Example: `Contributor` on the specified Azure Resource Group, or more fine-grained roles if you want.

```bash
humctl apply -f azure-blob-tf.yaml
```

_Do you want to know more about how to map your Terraform Modules with Resource Definitions? Read [this section](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/#matching-terraform-modules-to-resource-definitions)._

From there, you can deploy the App/Env where a Workload has an `azure-blob` dependency.

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
- Quick review of what's happening with the Operator
- Add `redis` with `template` (in-cluster) and `terraform` (in Azure)