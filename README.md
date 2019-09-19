# docker-eks-utils
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/cmdlabs/eks-utils.svg)](https://hub.docker.com/r/cmdlabs/eks-utils) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cmdlabs/eks-utils.svg)](https://hub.docker.com/r/cmdlabs/eks-utils/builds)

https://hub.docker.com/r/cmdlabs/eks-utils

## Overview

docker-eks-utils implements a container containing a variety of tools for managing your EKS cluster.

  * kubectl
  * Helm, including the [Tillerless Helm][] plugin
  * awscli
  * [kubectx][] (including [kubens][])
  * [velero][]

[Tillerless Helm]: https://github.com/rimusz/helm-tiller
[kubectx]: https://github.com/ahmetb/kubectx
[kubens]: https://github.com/ahmetb/kubectx/blob/master/kubens
[velero]: https://github.com/heptio/velero

## Usage

This container can be used with the [3 Musketeers][] pattern:

  * docker-compose.yml
```yml
  eks:
    image: cmdlabs/eks-utils:0.9.0
    env_file: .env
    working_dir: /work
    volumes:
      - .:/work
      - ~/.kube:/root/.kube
      - ~/.aws:/root/.aws
```

  * Makefile
```Makefile
deploy: .env kubeConfig
	docker-compose run --rm eks kubectl apply -f deployment.yml
```

[3 Musketeers]: https://3musketeers.io/
