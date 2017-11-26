#!/bin/bash

# 检查环境变量
if [ -z "$LFTP_HOST" ]; then
    echo "Need to set host"
    exit 1
fi
if [ -z "$LFTP_USERNAME" ]; then
    echo "Need to set username"
    exit 1
fi
if [ -z "$LFTP_SECURE" ]; then
    LFTP_SECURE="true"
fi
echo "set ftp:passive-mode off" > /etc/lftp.conf
echo "set ftp:charset utf8" > /etc/lftp.conf
echo "set net:timeout 10" > /etc/lftp.conf
echo "set pget:default-n 5" > /etc/lftp.conf
echo "set sftp:auto-confirm yes" > /etc/lftp.conf
# set net:max-retries 2;
# set net:reconnect-interval-base 5; \
# set net:reconnect-interval-multiplier 1; \


# 提取源文件路径数组
LFTP_EXCLUDE_STR=""
LFTP_INCLUDE_STR=""

OLD_IFS="$IFS"
IFS=","
in_arr=($LFTP_EXCLUDE)
IFS="$OLD_IFS"
for i in "${in_arr[@]}"; do
    LFTP_EXCLUDE_STR="$LFTP_EXCLUDE_STR -x $i"
done
if [ "$LFTP_DEBUG" = "true" ]; then
    echo "exclude："${LFTP_EXCLUDE_STR}
fi

OLD_IFS="$IFS"
IFS=","
in_arr=($LFTP_INCLUDE)
IFS="$OLD_IFS"
for i in "${in_arr[@]}"; do
    LFTP_INCLUDE_STR="$LFTP_INCLUDE_STR -x $i"
done
if [ "$LFTP_DEBUG" = "true" ]; then
    echo "include："${LFTP_EXCLUDE_STR}
fi

# 开始上传文件
echo "uploading..."
CMD="lftp -u $LFTP_USERNAME,$LFTP_PASSWORD $LFTP_MODEL://$LFTP_HOST:$LFTP_PORT"
if [ "$LFTP_DEBUG" = "true" ]; then
    echo "cmd："${CMD}
fi
eval $CMD" -e 'mirror -R $(pwd)/$LFTP_SOURCE $LFTP_TARGET; exit;'"

echo "All Done... See you next time."
