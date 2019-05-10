FROM makeomatic/node:$VERSION

# add extra packages
RUN \
  apk add --no-cache --virtual .flavorDeps \
    openssh \
    git
