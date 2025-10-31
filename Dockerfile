FROM node:22.21.1-bookworm-slim

# Install system dependencies required by YellowLabTools and Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libjpeg-dev \
    libpng-dev \
    zlib1g-dev \
    build-essential \
    autoconf \
    automake \
    libtool \
    nasm \
    pkg-config \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    DOCKERIZED=true

# Install YellowLabTools CLI globally
RUN npm install -g yellowlabtools

# Patch phantomas to add --no-sandbox for Docker and increase protocol timeout
RUN sed -i 's/if (env\["DOCKERIZED"\]) {/if (env["DOCKERIZED"]) {\n    options.args.push("--no-sandbox", "--disable-setuid-sandbox");/' \
    /usr/local/lib/node_modules/yellowlabtools/node_modules/phantomas/lib/browser.js && \
    sed -i 's/headless: "new",/headless: "new",\n    protocolTimeout: 180000,/' \
    /usr/local/lib/node_modules/yellowlabtools/node_modules/phantomas/lib/browser.js

# Create a non-root user to run the application
RUN groupadd -r yellowlab && \
    useradd -r -g yellowlab -G audio,video yellowlab && \
    mkdir -p /home/yellowlab/.cache && \
    chown -R yellowlab:yellowlab /home/yellowlab

# Set working directory
WORKDIR /app

# Switch to non-root user
USER yellowlab

# Set yellowlabtools as the entrypoint
ENTRYPOINT ["yellowlabtools"]

# Default command to show help
CMD ["--help"]
