# docker-eks-utils

https://hub.docker.com/r/cmdlabs/eks-utils

## Overview

docker-eks-utils implements a container containing a variety of tools for managing your EKS cluster.

  * kubectl
  * Helm v3
  * awscli

## Usage

This container can be used with the [3 Musketeers][] pattern:

  * docker-compose.yml
```yml
version: '3.7'
services:
  eks:
    image: cmdlabs/eks-utils:1.0.0
    env_file: .env
    working_dir: /work
    volumes:
      - .:/work
      - ~/.kube:/root/.kube
      - ~/.aws:/root/.aws
      - ~/.helm/repository:/root/.helm/repository
```

  * Makefile
```Makefile
deploy: .env kubeConfig
	docker-compose run --rm eks kubectl apply -f deployment.yml
```

[3 Musketeers]: https://3musketeers.io/
