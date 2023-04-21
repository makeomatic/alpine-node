FROM node

# installs pnpm package manager
RUN \
    npm install -g pnpm@8 \
    && pnpm config set global-bin-dir "$(npm prefix --location=global)/bin"
