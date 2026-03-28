FROM node:22-bookworm-slim

ARG N8N_VERSION=2.13.4

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg tini ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && npm install -g n8n@${N8N_VERSION}

WORKDIR /home/node

ENV NODE_ENV=production \
    N8N_HOST=0.0.0.0 \
    N8N_PROTOCOL=http \
    N8N_PROXY_HOPS=1 \
    FFMPEG_PATH=/usr/bin/ffmpeg

USER node

EXPOSE 8080

ENTRYPOINT ["tini", "--"]
CMD ["sh", "-c", "export N8N_PORT=${PORT:-8080} && n8n start"]
