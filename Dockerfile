# This dockerfile uses the alpine image
# VERSION 1 - EDITION 1
# Author: zero
# Command format: Instruction [arguments / command] ..

FROM alpine

MAINTAINER zero zero@gmail.com

RUN apk --no-cache add \
        libressl \
        lftp \
        bash

ADD main.sh /bin/
RUN chmod +x /bin/main.sh

ENTRYPOINT /bin/main.sh
