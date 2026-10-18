
# Stage 1: Install production dependencies
FROM node:20-alpine AS dependencies

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev \
    && npm cache clean --force


# Stage 2: Production runtime
FROM node:20-alpine AS production

ENV NODE_ENV=production

WORKDIR /app

# Update installed Alpine packages
RUN apk update \
    && apk upgrade \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/local/lib/node_modules/npm \
              /usr/local/lib/node_modules/corepack \
              /opt/yarn-v1.22.22 \
              /usr/local/bin/npm \
              /usr/local/bin/npx \
              /usr/local/bin/corepack \
              /usr/local/bin/yarn \
              /usr/local/bin/yarnpkg

# Copy production dependencies
COPY --from=dependencies --chown=node:node /app/node_modules ./node_modules

# Copy application source
COPY --chown=node:node package*.json ./
COPY --chown=node:node src/ ./src/

# Run as non-root user
USER node
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD node -e "fetch('http://127.0.0.1:5000/healthz').then(r => process.exit(r.ok ? 0 : 1)).catch(() => process.exit(1))"
CMD ["node", "src/server.js"]
