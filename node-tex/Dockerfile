FROM makeomatic/node:8.0.0

# add texlive
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --no-cache upgrade zlib \
  && apk add --no-cache texlive
