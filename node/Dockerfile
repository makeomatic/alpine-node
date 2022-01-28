FROM node:$VERSION-alpine

# installs pnpm package manager
RUN \
      wget -qO- https://get.pnpm.io/v6.16.js | node - add --global pnpm

LABEL vendor=makeomatic \
      version_tags="$VERSION_TAGS"

CMD [ "yarn", "start" ]
