FROM node:20

WORKDIR /app

# Install step CLI
COPY step_linux_0.30.0-rc1_amd64.tar.gz /tmp/
RUN tar -xzf /tmp/step_linux_0.30.0-rc1_amd64.tar.gz -C /tmp && \
    mv /tmp/step_*/bin/step /usr/local/bin/ && \
    rm -rf /tmp/step_* /tmp/step_linux_0.30.0-rc1_amd64.tar.gz

COPY package.json ./
COPY src ./src
COPY scripts/node-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV PORT=443
ENV STEPPATH=/root/.step

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
