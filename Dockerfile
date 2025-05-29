FROM alpine:3.21.3

ARG VERSION

ARG TARGETARCH
ENV ARCHIVE_URL_AMD64=https://github.com/nixys/nxs-data-anonymizer/releases/download/v$VERSION/nxs-data-anonymizer-amd64.tar.gz
ENV ARCHIVE_URL_ARM64=https://github.com/nixys/nxs-data-anonymizer/releases/download/v$VERSION/nxs-data-anonymizer-arm64.tar.gz

RUN apk add --no-cache curl tar bash

RUN set -eux; \
  case "$TARGETARCH" in \
    amd64) ARCHIVE_URL="$ARCHIVE_URL_AMD64" ;; \
    arm64) ARCHIVE_URL="$ARCHIVE_URL_ARM64" ;; \
    *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
  esac; \
  curl -L -o /tmp/nxs.tar.gz "$ARCHIVE_URL"; \
  tar -xzf /tmp/nxs.tar.gz -C /usr/local/bin; \
  chmod +x /usr/local/bin/nxs-data-anonymizer; \
  rm /tmp/nxs.tar.gz
