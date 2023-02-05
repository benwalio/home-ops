# Authentik

## Setup

> go to initial flow first

`https://authentik.your.domain/if/flow/initial-setup/`

### glauth LDAP backend

> configure glauth LDAP backend

Admin Panel > Directory > Federation

> server URI

`ldap://glauth.security.svc.cluster.local:389`

> bind CN

`cn=$GLAUTH_SEARCH_USER,ou=svcaccts,dc=home,dc=arpa`

> base DN

`dc=home,dc=arpa`

> user object filter

`(objectClass=posixAccount)`

> group object filter

`(objectClass=posixGroup)`

> group membership field

`memberOf`

> object uniqueness key

`cn`
