# MVP Workshop - Day 2 - As Developer,

- Golden path DEV-1: I want to deploy my Workload
- Golden path DEV-2: I want to see the status of the Deployment of my Workload
- Golden path DEV-3: I want to expose my Workload via a DNS

- [Prerequisites](#prerequisites)
- [Golden path DEV-1: I want to deploy my Workload](#golden-path-dev-1-i-want-to-deploy-my-workload)
- [Golden path DEV-2: I want to see the status of the Deployment of my Workload](#golden-path-dev-2-i-want-to-see-the-status-of-the-deployment-of-my-workload)
- [Golden path DEV-3: I want to expose my Workload via a DNS](#golden-path-dev-3-i-want-to-expose-my-workload-via-a-dns)
- [Resources](#resources)

## Prerequisites

- [ ] Let's select one container in your own registry, accessible from the cluster used during this workshop.
- [ ] Install [`humctl`](https://developer.humanitec.com/platform-orchestrator/cli/).
- [ ] Got an invite to join the Humanitec Org as `Member`.

```bash
humctl login
```

```bash
export HUMANITEC_ORG=FIXME

humctl config set org ${HUMANITEC_ORG}
```

## Golden path DEV-1: I want to deploy my Workload

`score.yaml`:
```yaml
apiVersion: score.dev/v1b1
metadata:
  name: my-sample-workload
containers:
  my-sample-container:
    image: .
```

```bash
humctl score validate score.yaml --strict
```

```bash
export IMAGE=FIXME

humctl score deploy -f score.yaml --image ${IMAGE} --app ${APP} --env development --wait
```

## Golden path DEV-2: I want to see the status of the Deployment of my Workload

Get teh Deploy status:
```bash
FIXME
```

Get the Deployment error:
```bash
humctl get deploy-error --app ${APP} --env development
```

Open the Humanitec Portal to see the Deployment status and information:
```bash
echo -e "https://app.humanitec.io/orgs/${HUMANITEC_ORG}/apps/${APP}/envs/development/"
```

Open the Humanitec Portal to see the logs of the running container:
```bash
echo -e "https://app.humanitec.io/orgs/${HUMANITEC_ORG}/apps/${APP}/envs/development/"
```

## Golden path DEV-3: I want to expose my Workload via a DNS

`score.yaml`:
```yaml
apiVersion: score.dev/v1b1
metadata:
  name: my-sample-workload
containers:
  my-sample-container:
    image: .
resources:
  dns:
    type: dns
  route:
    type: route
    params:
      host: ${resources.dns.host}
      path: /
      port: 8080
service:
  ports:
    tcp:
      port: 8080
      targetPort: 8080
```

```bash
humctl score deploy -f score.yaml --image ${IMAGE} --app ${APP} --env development --wait
```

## Resources

- [More Score file examples](https://developer.humanitec.com/examples/score/)