# Stage 1: Get static FFmpeg binaries
FROM mwader/static-ffmpeg:latest AS ffmpeg

# Stage 2: Build the actual n8n image
FROM n8nio/n8n:latest

USER root

# Copy FFmpeg binaries directly from Stage 1
COPY --from=ffmpeg /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /ffprobe /usr/local/bin/ffprobe

# Make them executable
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

USER node
