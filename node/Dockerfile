FROM node

# to pick up globally installed modules by pnpm
ENV PATH="$PATH:~/.local/bin"

RUN corepack enable \
    && su node -c 'corepack install --global pnpm@8.x' \
    && su node -c 'mkdir -p ~/.local/bin' \
    && su node -c 'pnpm config set global-bin-dir "~/.local/bin"'
