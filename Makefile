.PHONY: build test dgoss
DOCKER_USER = rvben
DOCKER_NAME = rvben/rpi-keepalived
VERSION := $(shell cat Dockerfile | grep -oP 'KEEPALIVED_VERSION=(.*)' | grep -oP '\d.\d.\d')
build:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t $(DOCKER_NAME) .

test:
	bash tests/verify_entrypoint.sh

dgoss:
	which dgoss || curl -fsSL https://goss.rocks/install | sh
	dgoss run $(DOCKER_NAME):latest

push:
	docker login -u="$(DOCKER_USER)" -p="$(DOCKER_PASS)"
	VERSION=$$(cat Dockerfile | grep -oP 'KEEPALIVED_VERSION=(.*)' | grep -oP '\d.\d.\d')
	docker tag $(DOCKER_NAME) $(DOCKER_NAME):$(VERSION)
	docker push $(DOCKER_NAME):$(VERSION)
	docker push $(DOCKER_NAME):latest
