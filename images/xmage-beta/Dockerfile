
# FROM adoptopenjdk/openjdk8:jre8u-alpine-nightly
# adoptopenjdk is now Deprecated
#FROM eclipse-temurin:17-jre-alpine
# also try 8-jre-focal or 11.0.13_8-jre-alpine
FROM alpine:3

# XMage settings

ENV JAVA_MIN_MEMORY=256M \
    JAVA_MAX_MEMORY=2G \
    JAVA_EXTENDED_OPTIONS="-XX:MaxPermSize=256m" \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8' \
    XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_SECONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server" \
    XMAGE_DOCKER_ADMIN_PASSWORD="password"\
    XMAGE_DOCKER_MAX_GAME_THREADS="10" \
    XMAGE_DOCKER_MIN_USERNAME_LENGTH="3" \
    XMAGE_DOCKER_MAX_USERNAME_LENGTH="14" \
    XMAGE_DOCKER_MIN_PASSWORD_LENGTH="8" \
    XMAGE_DOCKER_MAX_PASSWORD_LENGTH="100" \
    XMAGE_DOCKER_MAILGUN_API_KEY="X" \
    XMAGE_DOCKER_MAILGUN_DOMAIN="X" \
    XMAGE_DOCKER_SERVER_MSG="" \
    XMAGE_DOCKER_MADBOT_ENABLED=0

#Build and Configure Container
WORKDIR /xmage

# Build args
ARG XMAGE_VERSION
LABEL xmage_version="${XMAGE_VERSION}"


COPY dockerStartServer.sh /xmage/

RUN set -ex && \
    apk --no-cache -U upgrade && \
    apk --no-cache add openjdk8 curl ca-certificates jq && \
    curl --silent --show-error http://xmage.today/config.json | jq '.XMage.location' | xargs curl -# -L > xmage.zip \
    && unzip xmage.zip -x "mage-client*" \
    && mv /xmage/dockerStartServer.sh /xmage/mage-server/ \
    && chmod +x \
    /xmage/mage-server/startServer.sh \
    /xmage/mage-server/dockerStartServer.sh \
    && apk del --purge curl jq \
    && rm -rf xmage.zip /var/cache/apk/* /xmage/mage-server/startMage*.bat

EXPOSE $XMAGE_DOCKER_PORT $XMAGE_DOCKER_SECONDARY_BIND_PORT

WORKDIR /xmage/mage-server

CMD [ "./dockerStartServer.sh" ]
