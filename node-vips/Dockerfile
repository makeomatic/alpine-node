FROM makeomatic/node:10.13.0

# add libvips
RUN \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache \
    fftw@edge \
    vips@edge
