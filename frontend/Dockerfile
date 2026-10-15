# Stage 1: Build the React application
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build


# Stage 2: Serve using unprivileged Nginx
FROM nginxinc/nginx-unprivileged:stable-alpine

# Copy the production build
COPY --from=builder /app/dist/ /usr/share/nginx/html/

# Configure Nginx for frontend and backend communication
COPY default.conf.template /etc/nginx/templates/default.conf.template

# Substitute only backend environment variables in the template
ENV NGINX_ENVSUBST_FILTER="BACKEND_HOST|BACKEND_PORT"

# Nginx unprivileged image listens on port 8080
EXPOSE 8080

# Check whether Nginx is serving the application
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1