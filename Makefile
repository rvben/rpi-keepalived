.PHONY: build test dgoss
DOCKER_USER = rvben
DOCKER_NAME = rvben/rpi-keepalived

build:
	VERSION=$$(cat Dockerfile | grep -oP 'KEEPALIVED_VERSION=(.*)' | grep -oP '\d.\d.\d')
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t $(DOCKER_NAME) .

test:
	bash tests/verify_entrypoint.sh

dgoss:
	which dgoss || curl -fsSL https://goss.rocks/install | sh
	dgoss run $(DOCKER_NAME):latest
