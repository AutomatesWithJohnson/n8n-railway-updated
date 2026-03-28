FROM node:22-bookworm-slim

ARG N8N_VERSION=2.13.4

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg tini ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && npm install -g n8n@${N8N_VERSION} \
 && mkdir -p /home/node/.n8n \
 && chown -R node:node /home/node

ENV NODE_ENV=production \
    N8N_HOST=0.0.0.0 \
    N8N_PORT=5678 \
    N8N_PROTOCOL=http \
    N8N_USER_FOLDER=/home/node/.n8n

WORKDIR /home/node

USER node

EXPOSE 5678

ENTRYPOINT ["tini", "--"]
CMD ["n8n", "start"]
