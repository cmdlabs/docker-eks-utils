#!/usr/bin/env bash

set -euxo pipefail

kubectl --help
aws-iam-authenticator --help
helm --help
helm tiller --help
#Cant test helm diff as it requires a kubernetes cluster
aws --version