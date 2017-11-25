#!/bin/sh

if [ -z "$SFTP_HOST" ]; then
    echo "Need to set host"
    exit 1
fi


if [ -z "$SFTP_PORT" ]; then
    SFTP_PORT="21"
fi

if [ -z "$SFTP_USERNAME" ]; then
    echo "Need to set username"
    exit 1
fi

if [ -z "$SFTP_SECURE" ]; then
    SFTP_SECURE="true"
fi

if [ -z "$SFTP_DEST_DIR" ]; then
    SFTP_DEST_DIR="/"
fi

if [ -z "$SFTP_SRC_DIR" ]; then
    SFTP_SRC_DIR="/"
fi

SFTP_EXCLUDE_STR=""
SFTP_INCLUDE_STR=""

IFS=',' read -ra in_arr <<< "$SFTP_EXCLUDE"
for i in "${in_arr[@]}"; do
    SFTP_EXCLUDE_STR="$SFTP_EXCLUDE_STR -x $i"
done
IFS=',' read -ra in_arr <<< "$SFTP_INCLUDE"
for i in "${in_arr[@]}"; do
    SFTP_INCLUDE_STR="$SFTP_INCLUDE_STR -x $i"
done

lftp -c "open -u $SFTP_USERNAME,$SFTP_PASSWORD $SFTP_HOSTNAME:$SFTP_PORT; \
set ftp:ssl-force $SFTP_SECURE; \
set ftp:ssl-protect-data $SFTP_SECURE; 
mirror -R $SFTP_INCLUDE_STR $SFTP_EXCLUDE_STR $(pwd)$SFTP_SRC_DIR $SFTP_DEST_DIR"
