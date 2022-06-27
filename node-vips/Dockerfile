FROM makeomatic/node

# add libvips
RUN \
  apk --no-cache upgrade \
  && apk --no-cache add \
    fftw \
    vips

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/
