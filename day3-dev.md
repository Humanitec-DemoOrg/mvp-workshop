# MVP Workshop - Day 3 - As Developer,

- Golden path DEV-5: I want to use an Azure Blob Storage with my Workload
- Golden path DEV-6: I want to use an Azure Blob Storage and an Azure Service Principal with my Workload

## Golden path DEV-5: I want to use an Azure Blob Storage with my Workload

`score.yaml`:
```yaml
apiVersion: score.dev/v1b1
metadata:
  name: my-sample-workload
containers:
  my-sample-container:
    image: .
    variables:
      MY_BLOB_ACCOUNT: ${resources.my-blob.account}
      MY_BLOB_CONTAINER: ${resources.my-blob.container}
resources:
  my-blob:
    type: azure-blob
```

```bash
humctl score deploy -f score.yaml --image ${IMAGE} --app ${APP} --env development --wait
```

## Golden path DEV-6: I want to use an Azure Blob Storage and an Azure Service Principal with my Workload

`score.yaml`:
```yaml
apiVersion: score.dev/v1b1
metadata:
  name: my-sample-workload
containers:
  my-sample-container:
    image: .
    variables:
      MY_BLOB_ACCOUNT: ${resources.my-blob.account}
      MY_BLOB_CONTAINER: ${resources.my-blob.container}
      MY_SP_ID: ${resources.my-sp.id}
      MY_SP_TENANT: ${resources.my-sp.tenant}
      MY_SP_PASSWORD: ${resources.my-sp.password}
resources:
  my-blob:
    type: azure-blob
  my-sp:
    type: azure-service-principal
    for: ${resources.my-blob}
```

```bash
humctl score deploy -f score.yaml --image ${IMAGE} --app ${APP} --env development --wait
```