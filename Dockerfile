ARG DISTRO="alpine"
ARG DISTRO_VARIANT="3.18"

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV CONTAINER_ENABLE_MESSAGING=FALSE \
    IMAGE_NAME="tiredofit/mailhog" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-mailhog/"

RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package install .mailhog-build-deps \
               git \
               go \
               && \
    \
    go install github.com/mailhog/MailHog@latest && \
    mv /root/go/bin/MailHog /usr/sbin && \
    \
    package remove .mailhog-build-deps && \
    package cleanup && \
    rm -rf /root/.cache \
           /root/go

EXPOSE 1025 8025

COPY install/ /
