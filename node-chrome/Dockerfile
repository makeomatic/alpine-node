FROM makeomatic/node:$VERSION

# Installs latest Chromium (73) package.
RUN apk --no-cache upgrade && \
    apk --no-cache add \
      chromium \
      nss \
      font-noto \
      harfbuzz \
      freetype

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
