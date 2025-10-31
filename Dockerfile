FROM node:18-slim

# Install system dependencies required by YellowLabTools
RUN apt-get update && \
    apt-get install -y \
    libjpeg-dev \
    libfontconfig \
    && rm -rf /var/lib/apt/lists/*

# Install YellowLabTools CLI globally
RUN npm install -g yellowlabtools

# Set working directory
WORKDIR /app

# Default command to show help
CMD ["yellowlabtools", "--help"]
