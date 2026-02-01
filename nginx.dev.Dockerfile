FROM nginx

# Development version - requires SSL certificates for local testing
ARG CERT_FILE=nginx.crt
ARG KEY_FILE=nginx.key

# Copy SSL certs for local development
COPY ${CERT_FILE} /tmp/nginx.crt
COPY ${KEY_FILE} /tmp/nginx.key

COPY nginx.conf /etc/nginx/nginx.conf
COPY scripts/nginx-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Expose both ports for local development
EXPOSE 80 443

# No Cloudflare in development
ENV USE_CLOUDFLARE=false

ENTRYPOINT ["/entrypoint.sh"]
