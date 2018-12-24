FROM makeomatic/node:10.14.2

# add libvips
RUN \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache \
    fftw@edge \
    vips@edge
