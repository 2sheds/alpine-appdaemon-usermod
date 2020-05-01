FROM kurapov/alpine-appdaemon
MAINTAINER Oleg Kurapov <oleg@kurapov.com>

ARG BRANCH="none"
ARG VERSION="none"
ARG COMMIT="local-build"
ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG NAME="kurapov/alpine-appdaemon-usermod"
ARG VCS_URL="https://github.com/2sheds/alpine-appdaemon-usermod"

ARG UID="1001"
ARG GUID="1001"
ARG PACKAGES="py3-paramiko"
ARG DEPS="shadow"

LABEL \
  org.opencontainers.image.authors="Oleg Kurapov <oleg@kurapov.com>" \
  org.opencontainers.image.title="${NAME}" \
  org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.revision="${COMMIT}" \
  org.opencontainers.image.source="${VCS_URL}"

RUN apk add --update-cache ${PACKAGES} && \
    apk add --virtual=build-dependencies ${DEPS} && \
    usermod -u ${UID} appdaemon && groupmod -g ${GUID} appdaemon && \
    apk del build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

