FROM alpine:latest


# Configuration variables
# ENV HUGO_VERSION 0.101.0
ARG HUGO_VERSION
LABEL HUGO_VERSION="${HUGO_VERSION}"
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
ENV SITE_DIR '/usr/share/blog'

# Download and install hugo
RUN set -ex && \
    apk --no-cache add curl ca-certificates git asciidoc && \
				apk --no-cache add --update git npm libc6-compat libstdc++ && \
    curl -sL -o /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    tar -xf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /tmp/ \
    && mkdir -p /usr/local/sbin \
				&& mkdir -p ${SITE_DIR} \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_BINARY} \
    && rm -rf /tmp/LICENSE \
    && rm -rf /tmp/README.md \
				&& rm -rf /var/lib/apt/lists/* \
    && chmod +x /usr/local/sbin/hugo



WORKDIR ${SITE_DIR}

# Expose default hugo port
EXPOSE 80

# Automatically build site
ONBUILD ADD site/ ${SITE_DIR}
ONBUILD RUN hugo -d /usr/share/nginx/html/

# By default, serve site
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0 -p 80
