#!/bin/bash

# VER=$(curl http://xmage.today/config.json | jq '.XMage.version' | cut -d" " -f1 | sed "s/\"//g" )
VER=$(curl http://xmage.today/config.json | jq '.XMage.version' | sed "s/\"//g ;s/\ /\-/g; s/(//g; s/)//g" )
docker build --build-arg XMAGE_VERSION=${VER} -t "xmagebeta-alpine:${VER}" .
#
#docker rmi "xmagebeta-alpine:${VER}"
docker tag "xmagebeta-alpine:${VER}" "harbor.ragazzilab.com/library/xmagebeta-alpine:${VER}"
docker push "harbor.ragazzilab.com/library/xmagebeta-alpine:${VER}"
docker rmi harbor.ragazzilab.com/library/xmagebeta-alpine:latest
docker tag "harbor.ragazzilab.com/library/xmagebeta-alpine:${VER}" "harbor.ragazzilab.com/library/xmagebeta-alpine:latest"
docker push "harbor.ragazzilab.com/library/xmagebeta-alpine:latest"


# docker tag xmagebeta-alpine:$VER ragazzilab/xmagebeta-alpine:$VER
# docker push ragazzilab/xmagebeta-alpine:$VER
# docker rmi ragazzilab/xmagebeta-alpine:latest
# docker tag ragazzilab/xmagebeta-alpine:$VER ragazzilab/xmagebeta-alpine:latest
# docker push ragazzilab/xmagebeta-alpine:latest
