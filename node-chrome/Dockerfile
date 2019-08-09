FROM makeomatic/node:$VERSION

# Installs latest Chromium (76) package.
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk --no-cache upgrade \
    && apk --no-cache add \
      chromium@edge \
      nss@edge \
      font-noto@edge \
      harfbuzz@edge \
      freetype@edge

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
