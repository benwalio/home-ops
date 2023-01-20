# useful commands

## flux

### create

```
flux create source helm podinfo \
    --url=https://stefanprodan.github.io/podinfo \
    --interval=1h \
    --export > ./kubernetes/flux/repositories/helm/podinfo.yaml
```

## rook

```
k logs -n rook-ceph -l app=rook-ceph-operator
```

### run tools

```
k -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
```
