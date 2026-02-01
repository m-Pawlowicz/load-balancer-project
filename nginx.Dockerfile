FROM nginx

# Production version - no SSL certificates needed (served via Cloudflare tunnel)
COPY nginx.prod.conf /etc/nginx/nginx.conf
COPY scripts/nginx-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Expose port 80 for Cloudflare tunnel
EXPOSE 80

# Always use Cloudflare in production
ENV USE_CLOUDFLARE=true

ENTRYPOINT ["/entrypoint.sh"]
