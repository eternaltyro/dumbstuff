# Containerise tools for simplicity

Several CLI tools can be run via container runtimes instead of having to
install them using package managers. The advantage of this is to
maintain a clean workstation with minimal cruft.


## AWS CLI

AWS CLI container with the `.aws` directory (containing credentials)
mounted.

```
function aws { podman run --rm --mount type=bind,source="${HOME}"/.aws,target=/root/.aws,readonly --mount type=tmpfs,destination=/tmp -it docker.io/amazon/aws-cli "$@"; }
```

## Gitlab Runner

```
function gitlab-runner { podman run --rm -it gitlab/gitlab-runner "$@"; }
```

## Open Policy Agent

```
function opa { podman run --rm -it docker.io/openpolicyagent/opa "$@"; }
```

```
function opa { podman run --rm -p 8181:8181 docker.io/openpolicyagent/opa run --server --addr :8181; }
```


