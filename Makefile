VERSION = 0.7.0
IMAGE_NAME ?= cmdlabs/eks-utils

build:
	docker build -t $(IMAGE_NAME):testing .
PHONY: build

test:
	docker-compose -f docker-compose.test.yml up --build --quiet-pull --exit-code-from sut
	docker-compose -f docker-compose.test.yml down --rmi all
PHONY: test

clean:
	docker-compose -f docker-compose.test.yml down --rmi all 
PHONY: clean

tag:
	git tag $(VERSION)
	git push origin $(VERSION)
PHONY: tag
