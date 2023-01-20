# onepassword

## config

### ./clustersecretstore.yaml

```
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{VAULT NAME}}: 1
```

### secret.sops.yaml

```
stringData:
  1password-credentials.json:
```

This is your base64 encoded `1password-credentials.json` file. See links and commands below

```
stringData:
  token:
```

API token from 1pass setup

## ext docs

- https://developer.1password.com/docs/connect/connect-server-configuration
- https://developer.1password.com/docs/connect/aws-ecs-fargate/#getting-started

## cmds

`cat 1password-credentials.json | base64 | tr '/+' '_-' | tr -d '=' | tr -d '\n'`
