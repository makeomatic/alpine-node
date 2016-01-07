shell := /bin/bash
NODE_VERSIONS := 5.4.0 5.3.0 4.2.3
THIS_FILE := $(lastword $(MAKEFILE_LIST))
REPO := makeomatic
IMAGE := alpine-node
DIST := $(REPO)/$(IMAGE)

%.build-ssh:
	docker build $(BUILD_ARG) -t $(IMAGE_NAME)-ssh -f Dockerfile.ssh .

%.build:
	docker build $(BUILD_ARG) -t $(IMAGE_NAME) .

%.push:
	docker push $(IMAGE_NAME)
	docker push $(IMAGE_NAME)-ssh

%.push-ssh:
	docker push $(IMAGE_NAME)-ssh

%.pull:
	docker pull $(IMAGE_NAME)
	docker pull $(IMAGE_NAME)-ssh

all: build build-ssh push push-ssh

%: NODE_VER = $(basename $@)
%: BUILD_ARG = --build-arg VERSION=v$(NODE_VER)
%: IMAGE_NAME = $(DIST):$(NODE_VER)
%::
	@echo $@  # print target name
	@$(MAKE) -f $(THIS_FILE) $(addsuffix .$@, $(NODE_VERSIONS))

.PHONY: all %.build %.push %.push-ssh %.build-ssh %.pull
