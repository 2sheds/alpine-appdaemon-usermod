FROM kurapov/alpine-appdaemon
MAINTAINER Oleg Kurapov <oleg@kurapov.com>

ARG UID="1001"
ARG GUID="1001"
ARG DEPS="shadow"

RUN apk add --no-cache --virtual=build-dependencies ${DEPS} && \
    usermod -u ${UID} appdaemon && groupmod -g ${GUID} appdaemon && \
    apk del build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

