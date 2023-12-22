FROM node

RUN echo 'export PATH="$PATH:$HOME/.local/bin"' > /etc/profile.d/30-local-path.sh \
    && corepack enable \
    && su node -c 'corepack install --global pnpm@8.x' \
    && su node -c 'mkdir -p ~/.local/bin' \
    && su node -c 'pnpm config set global-bin-dir "~/.local/bin"'
