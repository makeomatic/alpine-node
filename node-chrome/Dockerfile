FROM makeomatic/node:$VERSION

# Installs latest Chromium (76) package.
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk --no-cache upgrade \
    && apk --no-cache add \
      chromium \
      nss \
      font-noto \
      harfbuzz \
      freetype \
   && rm -rf /var/cache/* \
   && mkdir /var/cache/apk

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
   && adduser -D chrome \
   && chown -R chrome:chrome /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
  CHROME_PATH=/usr/lib/chromium/ \
  PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
