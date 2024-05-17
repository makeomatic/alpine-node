FROM node

ENV COREPACK_DEFAULT_TO_LATEST=0 \
    COREPACK_ENABLE_DOWNLOAD_PROMPT=0 \
    COREPACK_ENABLE_NETWORK=0 \
    COREPACK_ENABLE_AUTO_PIN=0 \
    COREPACK_ENABLE_PROJECT_SPEC=0 \
    COREPACK_HOME=/usr/local/src/corepack

RUN \
    mkdir -p -g node $COREPACK_HOME \
    && corepack enable \
    && COREPACK_ENABLE_NETWORK=1 corepack install --global pnpm@8.x \
    && su node -c 'pnpm config set global-bin-dir "/usr/local/bin"' \
    && su node -c 'rm -rf ~/.cache ~/.npm' \
    && rm -rf ~/.npm \
    && chown -R root:node /usr/local/bin \
    && chmod g+w /usr/local/bin
