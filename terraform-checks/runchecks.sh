#!/usr/bin/env bash
# set -x

# Terraform Compliance
function terraform-compliance {
    podman run --rm -v "$(pwd):/target" -it docker.io/eerkunt/terraform-compliance "$@";
}
#terraform-compliance --features tests/compliance --planfile plan.out.json

# TFSec
function tfsec {
    podman run --rm -v "$(pwd):/src" -it docker.io/liamg/tfsec /src; 
}
# tfsec

# Terrascan
function terrascan {
    podman run --tty --volume "$(pwd):/src" docker.io/tenable/terrascan "$@";
}

# Infracost

# Checkov
function checkov {
    podman run --tty --volume "$(pwd):/tf" docker.io/bridgecrew/checkov --directory /tf
}
