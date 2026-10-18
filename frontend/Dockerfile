
# Stage 1: Build the React application
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Serve using unprivileged Nginx
FROM nginxinc/nginx-unprivileged:stable-alpine

# Update Alpine packages for available security fixes
USER root
RUN apk update && apk upgrade && rm -rf /var/cache/apk/*
USER 101

# Copy the production build
COPY --from=builder /app/dist/ /usr/share/nginx/html/

# Configure frontend and backend communication
COPY default.conf.template /etc/nginx/templates/default.conf.template

ENV NGINX_ENVSUBST_FILTER="BACKEND_HOST|BACKEND_PORT"

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
