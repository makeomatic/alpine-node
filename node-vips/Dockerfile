FROM makeomatic/node:7.1.0

# add libvips
RUN \
  echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache vips@testing
