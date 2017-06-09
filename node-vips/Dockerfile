FROM makeomatic/node:8.1.0

# add libvips
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && echo "@local http://cdn.matic.ninja/apk/community" >> /etc/apk/repositories \
  && printf '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA29qkaf8HSeDwWO8MNipl\nPsiCdwETf9QK/k5ZoUyCF6xtBYg4BFcfAjdyzP5+uJmdIIfyWbrw8D7QCNVlSqTh\nzL4vm3X3ezLYdbm+QTr12aXLafJQI1FVvU+pRK3zsI0E2tjgLKdLBTLAe/aIzPbS\nLmsKPym/T3e2nNngyw+csvuLSQusgSrsiOt/6FZYFUMqTh2P6wfv+CHqyyqy3kK6\nQof/BWeX1aWisJYt/9nyXGJSyvi4KlxVrD6KIcw1mB4+UsN1VlK3YPBSHbA37y6D\nlhJd5rr47YqmQUyr+ooFQ0DGXVXJ/zDq8PiTq5dTvgwcMZAHt96W2gY0UFxt0waZ\nWwIDAQAB\n-----END PUBLIC KEY-----' > /etc/apk/keys/v@aminev.me-57586a31.rsa.pub \
  && apk add --no-cache \
    fftw \
    vips@testing
