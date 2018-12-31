FROM makeomatic/node:10.15.0

# Installs latest Chromium (64) package.
RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk --no-cache upgrade && \
    apk --no-cache add \
      chromium@edge \
      nss@edge \
      font-noto@edge \
      harfbuzz@edge \
      freetype@edge

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
