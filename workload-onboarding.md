# Workload onboarding


## Assessment

- [ ] Project Name
- [ ] Diagram
- [ ] Helm chart per Workload? Same or different?
- [ ] What kind of Kubernetes manifests is finally deployed
- [ ] Deployment method and flow
- [ ] External Dependencies
  - [ ] Type (dns, db, secrets)
    - [ ] Provisioning method
    - [ ] Access method
    - [ ] Used by who
    - [ ] Associated env vars
- [ ] Start with 1st, 2nd, etc. which ones in which order? (Tips: from least amount of dependencies to most)
- [ ] Docker Compose?

## Prerequisities

- [ ] `humctl` locally?
- [ ] `Member` in Humanitec Org
- [ ] Create a branch in your existing repo to create Score files and update existing pipelines (why not apps too)
- [ ] Ok to deploy in existing cluster? Container images pullable from there?
- [ ] Access to both clusters?
- [ ] Humanitec App onboarded

## Let's do it!

- [ ] Humanitec App onboarding
- [ ] `humctl score init`
- [ ] Per Workload
  - [ ] Edit Score file with first Workload
  - [ ] `humctl score deploy`
  - [ ] Check logs in Humanitec
  - [ ] (Debugging) Check logs in Kubernetes
  - [ ] Look at the `Deployment` and map either in:
    - `score.yaml`
    - `humanitec.score.yaml`
    - `workload` res def
  - [ ] Inject Env vars
- [ ] Per external dependency
  - [ ] Type
  - [ ] Driver Type
  - [ ] Res Def

TODOs later:
- [ ] _Capture here what could be delayed in order to make progress and see/show values._

## Resources

- [Migrate an Application](https://developer.humanitec.com/introduction/tutorials/tutorials-for-pes/migrate-an-application/)