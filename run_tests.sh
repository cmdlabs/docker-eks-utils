#!/usr/bin/env bash

set -euxo pipefail

kubectl --help
helm --help
helm tiller --help
#Cant test helm diff as it requires a kubernetes cluster
aws --version
velero help
