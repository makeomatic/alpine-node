FROM makeomatic/node:$VERSION

# add libvips
RUN \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache \
    fftw@edge \
    vips@edge
