FROM makeomatic/node:$VERSION

# add libvips
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/main/community" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && apk --no-cache upgrade \
  && apk --no-cache add \
    fftw \
    vips

# Add Chrome as a user
RUN mkdir -p /src \
    && adduser -D node \
    && chown -R node:node /src

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/
