# Makeomatic base images

[![Build Status](https://travis-ci.org/makeomatic/alpine-node.svg?branch=master)](https://travis-ci.org/makeomatic/alpine-node)
[![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/r/makeomatic/node)
[![DockerHub](https://img.shields.io/docker/pulls/makeomatic/node.svg)](https://hub.docker.com/r/makeomatic/node)

Contains the following base images:

* node versions:
  - 8.1.4
  - 8.1.4-ssh (with openssh installed)
  - 8.1.4-vips (with libvips installed)
  - 8.1.4-vips-ssh (ssh+vips)
  - 8.1.4-ruby (with ruby 2.3.1 installed)

## Currently disabled

* rabbitmq:
  - 3.5.7 + autoclustering and many other plugins
