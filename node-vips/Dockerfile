FROM makeomatic/node:10.11.0

# add libvips
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache \
    fftw \
    vips
