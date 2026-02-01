FROM nginx

# Build arguments
ARG USE_CLOUDFLARE=false
ARG CERT_FILE=nginx.crt
ARG KEY_FILE=nginx.key

# Copy SSL certs (will use defaults locally, can be overridden on VPS)
COPY ${CERT_FILE} /tmp/nginx.crt
COPY ${KEY_FILE} /tmp/nginx.key

COPY nginx.conf /etc/nginx/nginx.conf
COPY scripts/nginx-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Expose both ports (entrypoint will choose based on USE_CLOUDFLARE)
EXPOSE 80 443

ENV USE_CLOUDFLARE=${USE_CLOUDFLARE}

ENTRYPOINT ["/entrypoint.sh"]
