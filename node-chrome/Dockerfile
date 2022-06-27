FROM makeomatic/node

# Installs latest Chromium (76) package.
RUN apk --no-cache upgrade \
    && apk --no-cache add \
      chromium \
      nss \
      font-noto \
      harfbuzz \
      freetype \
   && rm -rf /var/cache/* \
   && mkdir /var/cache/apk \
   && mkdir -p /usr/src/app \
   && addgroup chrome \
   && adduser -D chrome -G chrome \
   && chown -R chrome:chrome /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
  CHROME_PATH=/usr/lib/chromium/ \
  PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
