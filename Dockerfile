# This dockerfile uses the alpine image
# VERSION 1 - EDITION 1
# Author: zero
# Command format: Instruction [arguments / command] ..

FROM alpine

MAINTAINER zero 504715341@qq.com

RUN apk --no-cache add \
        openssh \
        lftp \
        bash

ADD main.sh /bin/
RUN chmod +x /bin/main.sh

ENV LFTP_MODEL=sftp \
    LFTP_PORT=22 \
    LFTP_SOURCE=/ \
    LFTP_TARGET=/ \
    LFTP_EXCLUDE="" \
    LFTP_INCLUDE="" \
    LFTP_DEBUG=false

ENTRYPOINT /bin/main.sh
