FROM makeomatic/node:6.9.1

# add libvips
RUN \
  echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache vips@testing
