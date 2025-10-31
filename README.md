# YellowLabTools CLI Docker

Docker container for [YellowLabTools](https://github.com/YellowLabTools/YellowLabTools) CLI - a tool for analyzing web page performance and quality.

## Usage

Pull the image from GitHub Container Registry:

```bash
docker pull ghcr.io/metadrop/docker-yellowlabtools-cli:latest
```

### Run an analysis

```bash
docker run --rm ghcr.io/metadrop/docker-yellowlabtools-cli:latest https://example.com
```

### Save results to a file

```bash
docker run --rm -v $(pwd):/output ghcr.io/metadrop/docker-yellowlabtools-cli:latest \
  yellowlabtools https://example.com --output /output/report.json
```

### Interactive mode

```bash
docker run --rm -it ghcr.io/metadrop/docker-yellowlabtools-cli:latest /bin/bash
```

## Building locally

```bash
docker build -t yellowlabtools .
docker run --rm yellowlabtools https://example.com
```

## CI/CD

This repository uses GitHub Actions to automatically build and push Docker images to GitHub Container Registry (ghcr.io).

Images are built on:
- Every push to `main`/`master` branch (tagged as `latest`)
- Every git tag starting with `v` (e.g., `v1.0.0`)

## License

This Dockerfile is provided as-is. YellowLabTools has its own license - see the [original repository](https://github.com/YellowLabTools/YellowLabTools).
