FROM node

# installs pnpm package manager
RUN \
    npm install -g pnpm@7 \
    && pnpm config set global-bin-dir `npm bin --location=global`
