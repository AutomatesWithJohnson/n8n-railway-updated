# Stage 1
FROM ubuntu:22.04 AS builder

RUN apt-get update && \
    apt-get install -y ffmpeg

# Stage 2
FROM n8nio/n8n:latest

USER root

COPY --from=builder /usr/bin/ffmpeg /usr/bin/
COPY --from=builder /usr/bin/ffprobe /usr/bin/
COPY --from=builder /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/

USER node
