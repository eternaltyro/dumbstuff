# Containerise tools for simplicity

## AWS CLI

```
function aws { podman run --rm --mount type=bind,source="${HOME}"/.aws,target=/root/.aws,readonly --mount type=tmpfs,destination=/tmp -it docker.io/amazon/aws-cli "$@"; }
```

## Open Policy Agent

```
function opa { podman run --rm -it docker.io/openpolicyagent/opa "$@"; }
```

```
function opa { podman run --rm -p 8181:8181 docker.io/openpolicyagent/opa run --server --addr :8181; }
```


