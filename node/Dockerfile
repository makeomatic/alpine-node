FROM node

# installs pnpm package manager
RUN \
    npm install -g pnpm \
    && pnpm config set global-bin-dir `npm bin --location=global`
