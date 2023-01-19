# useful commands

## flux

### create

```
flux create source helm podinfo \
    --url=https://stefanprodan.github.io/podinfo \
    --interval=1h \
    --export > ./kubernetes/flux/repositories/helm/podinfo.yaml
```
