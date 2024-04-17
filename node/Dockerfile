FROM node

ENV COREPACK_DEFAULT_TO_LATEST=0 \
    COREPACK_ENABLE_DOWNLOAD_PROMPT=0

RUN corepack enable \
    && corepack install --global pnpm@8.x \
    && su node -c 'pnpm config set global-bin-dir "/usr/local/bin"' \
    && su node -c 'rm -rf ~/.cache ~/.npm' \
    && rm -rf ~/.npm \
    && chown -R root:node /usr/local/bin \
    && chmod g+w /usr/local/bin
