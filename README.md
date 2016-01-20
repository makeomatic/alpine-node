# Alpine node makeomatic base image

Contains base image for node-based applications with npm and standard libs installed.
It uses `ONBUILD` instructions, so that eventual setup should be minimal: adding ports, env vars and volumes

Check example of Makefile for node-based app in the appropriate folder. Requires `docker >= 1.9.0`

## Available tags

* `makeomatic/alpine-node:5.4.0`
* `makeomatic/alpine-node:5.3.0`
* `makeomatic/alpine-node:4.2.3`
* `makeomatic/alpine-node:5.4.0-onbuild`
* `makeomatic/alpine-node:5.3.0-onbuild`
* `makeomatic/alpine-node:4.2.3-onbuild`
* `makeomatic/alpine-node:5.4.0-ssh`
* `makeomatic/alpine-node:5.3.0-ssh`
* `makeomatic/alpine-node:4.2.3-ssh`
* `makeomatic/alpine-node:5.4.0-ssh-onbuild`
* `makeomatic/alpine-node:5.3.0-ssh-onbuild`
* `makeomatic/alpine-node:4.2.3-ssh-onbuild`

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

### Use-case for node-makefile example

0. Install `gettext` package on OS X, `brew install gettext`, `brew link --force gettext`. It will give you `envsubst` package
1. Copy `Makefile`, `.dockerignore` and `Dockerfile` from `node-makefile` to your project
2. Extend `Dockerfile` with your project-specific settings, for instance, if you run an http server - expose it's ports, final Dockerfile example:

```Dockerfile
FROM makeomatic/alpine-node:$NODE_VERSION

VOLUME [ "/configs" ]

EXPOSE 8080
```

3. start `sinopia` container for NPM cache and faster builds or specify `NPM_PROXY=https://registry.npmjs.com`
4. by default we build "development" and "production" envs, you can overwrite them by settings "ENVS=production" to build only production env
5. now build containers like this:

```sh
# option 1 with overwriting configs
# Output will include:
#   `makeomatic/<nodejs-pkg-name>:5.3.0`
#   `makeomatic/<nodejs-pkg-name>:5.2.0`
#   `makeomatic/<nodejs-pkg-name>:5.3.0-<nodejs-pkg-version>`
#   `makeomatic/<nodejs-pkg-name>:5.2.0-<nodejs-pkg-version>`
make NODE_VERSIONS="5.3.0 5.2.0" NPM_PROXY=https://registry.npmjs.com ENVS="production" build

# option 2 - with defaults
# Output will include:
#   `makeomatic/<nodejs-pkg-name>:5.3.0-development`
#   `makeomatic/<nodejs-pkg-name>:4.2.3-development`
#   `makeomatic/<nodejs-pkg-name>:5.3.0`
#   `makeomatic/<nodejs-pkg-name>:4.2.3`
#   `makeomatic/<nodejs-pkg-name>:5.3.0-<nodejs-pkg-version>`
#   `makeomatic/<nodejs-pkg-name>:4.2.3-<nodejs-pkg-version>`
make build

# download images to your machine
make pull

# push all tagged images to public dist
make push
```

#### Testing env

1. copy `docker-compose.yml` into test folder
2. run `make test`
