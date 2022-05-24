FROM tiredofit/alpine:3.16
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV CONTAINER_ENABLE_MESSAGING=FALSE \
    IMAGE_NAME="tiredofit/mailhog" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-mailhog/"

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .mailhog-build-deps \
               git \
               go \
               && \
    \
    go install github.com/mailhog/MailHog@latest && \
    mv /root/go/bin/MailHog /usr/sbin && \
    rm -rf /root/.cache && \
    rm -rf /root/go && \
    \
    apk del .mailhog-build-deps && \
    rm -rf /var/cache/apk/*

EXPOSE 1025 8025

ADD install/ /
