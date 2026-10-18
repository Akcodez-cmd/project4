FROM nginxinc/nginx-unprivileged:stable-alpine
USER root
RUN apk update && apk upgrade && rm -rf /var/cache/apk/*
USER 101
COPY --from=builder /app/dist/ /usr/share/nginx/html/