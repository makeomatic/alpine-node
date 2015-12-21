shell := /bin/bash
NODE_VERSIONS := 5.3.0 5.2.0 5.1.1
THIS_FILE := $(lastword $(MAKEFILE_LIST))

%.build:
	docker build --build-arg VERSION=v$(basename $@) -t makeomatic/alpine-node:$(basename $@) .

%.push:
	docker push makeomatic/alpine-node:$(basename $@)

all: build push

%::
	@echo $@  # print target name
	@$(MAKE) -f $(THIS_FILE) $(addsuffix .$@, $(NODE_VERSIONS))

.PHONY: all %.build %.push
