# useful commands

## flux

### create

```
flux create source helm podinfo \
    --url=https://stefanprodan.github.io/podinfo \
    --interval=10m \
    --export > ./kubernetes/flux/repositories/helm/podinfo.yaml
```
