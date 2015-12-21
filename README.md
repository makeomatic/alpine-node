# Alpine node makeomatic base image

Contains base image for node-based applications with npm and standard libs installed.
It uses `ONBUILD` instructions, so that eventual setup should be minimal: adding ports, env vars and volumes

Check example of Makefile for node-based app in the appropriate folder. Requires `docker >= 1.9.0`

## Available tags

1. `makeomatic/alpine-node:5.3.0`
2. `makeomatic/alpine-node:5.2.0`
3. `makeomatic/alpine-node:5.1.1`

## Dockerizing node apps

`Dockerfile` contains basic images with NPM and modules for compiling native extensions installed.
This is controlled through 2 build args:

1. `VERSION=v5.1.0`
2. `NPM_VERSION=3`

Futhermore, it creates an onbuild image, which adds `package.json`, installed deps with a given NODE_ENV,
using NPM_PROXY as `registry`. One may use [docker-sinopia](https://github.com/foss-haas/docker-sinopia) launched
as `docker run --restart=always --name sinopia -d -p 4873:4873 pluma/sinopia` for that task to speed up the builds

### Available ONBUILD ARGs

When creating your own build, use these onbuild args

1. `WORKDIR=/src`
2. `NODE_ENV=production`
3. `NPM_PROXY=https://registry.npmjs.com`

Example `.dockerignore` is given in the `node-makefile` dir
