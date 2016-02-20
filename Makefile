SHELL := /bin/bash
NODE_VERSIONS := 5.6.0 4.3.1
THIS_FILE := $(lastword $(MAKEFILE_LIST))
REPO := makeomatic
IMAGE := alpine-node
DIST := $(REPO)/$(IMAGE)
PHANTOMJS_VERSION := 1.9.8

%.build-phantom:
	PHANTOMJS_VERSION=$(PHANTOMJS_VERSION) NODE_VER=$(NODE_VER) envsubst < ./alpine-phantom/Dockerfile | docker build -t $(IMAGE_NAME)-phantom -

%.build-vips:
	$(DOCKER) -t $(IMAGE_NAME)-vips - < ./alpine-node/Dockerfile.vips
	NODE_VER=$(NODE_VER) envsubst '$$NODE_VER' < ./alpine-node-onbuild/Dockerfile.vips | docker build -t $(IMAGE_NAME)-vips-onbuild -

%.build-vips-ssh:
	NODE_VER=$(NODE_VER) envsubst '$$NODE_VER' < ./alpine-node/Dockerfile.vips-ssh | docker build -t $(IMAGE_NAME)-vips-ssh -
	NODE_VER=$(NODE_VER) envsubst '$$NODE_VER' < ./alpine-node-onbuild/Dockerfile.vips-ssh | docker build -t $(IMAGE_NAME)-vips-ssh-onbuild -

%.build-ssh:
	$(DOCKER) -t $(IMAGE_NAME)-ssh - < ./alpine-node/Dockerfile.ssh
	NODE_VER=$(NODE_VER) envsubst '$$NODE_VER' < ./alpine-node-onbuild/Dockerfile.ssh | docker build -t $(IMAGE_NAME)-ssh-onbuild -

%.build:
	$(DOCKER) -t $(IMAGE_NAME) - < ./alpine-node/Dockerfile
	NODE_VER=$(NODE_VER) envsubst '$$NODE_VER' < ./alpine-node-onbuild/Dockerfile | docker build -t $(IMAGE_NAME)-onbuild -

push:
	docker push $(DIST)

%.pull:
	docker pull $(IMAGE_NAME)
	docker pull $(IMAGE_NAME)-onbuild
	docker pull $(IMAGE_NAME)-ssh
	docker pull $(IMAGE_NAME)-ssh-onbuild
	docker pull $(IMAGE_NAME)-vips
	docker pull $(IMAGE_NAME)-vips-onbuild

all: build build-ssh build-vips build-vips-ssh push

%: NODE_VER = $(basename $@)
%: BUILD_ARG = --build-arg VERSION=v$(NODE_VER)
%: IMAGE_NAME = $(DIST):$(NODE_VER)
%: DOCKER = docker build $(BUILD_ARG)
%::
	@echo $@  # print target name
	@$(MAKE) -f $(THIS_FILE) $(addsuffix .$@, $(NODE_VERSIONS))

.PHONY: all %.build %.build-ssh %.build-vips %.build-vips-ssh %.pull push
