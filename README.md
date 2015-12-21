# Alpine node makeomatic base image

Contains base image for node-based applications with npm and standard libs installed.
It uses `ONBUILD` instructions, so that eventual setup should be minimal: adding ports, env vars and volumes

Check example of Makefile for node-based app in the appropriate folder

## Available tags

1. `makeomatic/alpine-node:5.3.0`
2. `makeomatic/alpine-node:5.2.0`
3. `makeomatic/alpine-node:5.1.1`
