FROM kurapov/alpine-appdaemon
MAINTAINER Oleg Kurapov <oleg@kurapov.com>

ARG PKG_ARCH="amd64"
ARG ALPINE_VER="3.11"
ARG BRANCH="none"
ARG VERSION="none"
ARG COMMIT="local-build"
ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG NAME="kurapov/alpine-appdaemon-usermod"
ARG VCS_URL="https://github.com/2sheds/alpine-appdaemon-usermod"

ARG UID="1001"
ARG GUID="1001"
ARG PACKAGES
ARG PLUGINS="paramiko"
ARG DEPS="shadow"

LABEL \
  org.opencontainers.image.authors="Oleg Kurapov <oleg@kurapov.com>" \
  org.opencontainers.image.title="${NAME}" \
  org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.revision="${COMMIT}" \
  org.opencontainers.image.source="${VCS_URL}"

ENV WHEELS_LINKS="https://wheels.home-assistant.io/alpine-${ALPINE_VER}/${PKG_ARCH}/"

RUN apk add --no-cache --virtual=build-dependencies build-base ${DEPS} && \
    usermod -u ${UID} appdaemon && groupmod -g ${GUID} appdaemon && \
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir --prefer-binary --find-links ${WHEELS_LINKS} ${PLUGINS} && \
    apk del build-dependencies && \
    rm -rf /tmp/* /var/tmp/*

