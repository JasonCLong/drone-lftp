#!/bin/bash

# 记录执行开始时间
start_time=$(date +%s%N)
start_ms=${start_time:0:13}

# 检查参数是否合法
if [ -z "$LFTP_HOST" ]; then
    echo "Need to set host."
    exit 1
fi
if [ -z "$LFTP_USERNAME" ]; then
    echo "Need to set username."
    exit 1
fi
if [ -z "$LFTP_SECURE" ]; then
    LFTP_SECURE="true"
fi
# 检查目标路径，必须为绝对目录
if [ ${LFTP_TARGET:0:1} != '/' ]; then
    echo "Target path must be a absolute path."
    exit 1
fi
echo "set ftp:passive-mode off" > /etc/lftp.conf
echo "set ftp:charset utf8" > /etc/lftp.conf
echo "set net:timeout 10" > /etc/lftp.conf
echo "set pget:default-n 5" > /etc/lftp.conf
echo "set sftp:auto-confirm yes" > /etc/lftp.conf
# set net:max-retries 2;
# set net:reconnect-interval-base 5; \
# set net:reconnect-interval-multiplier 1; \


# 提取忽略上传的源文件路径数组,正则
LFTP_EXCLUDE_STR=""
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

# 提取需要上传的源文件路径数组，正则
LFTP_INCLUDE_STR=""
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

# 检查源文件路径位置，区分相对路径和绝对路径
P_SOURCE=""
if [ ${LFTP_SOURCE:0:2} = './' ]; then
P_SOURCE=$(pwd)/${LFTP_SOURCE#*./}
elif [ ${LFTP_SOURCE:0:1} = '/' ]; then
P_SOURCE=$LFTP_SOURCE
else
P_SOURCE=$(pwd)/$LFTP_SOURCE
fi

# 开始上传文件
CMD="lftp -u $LFTP_USERNAME,$LFTP_PASSWORD $LFTP_MODEL://$LFTP_HOST:$LFTP_PORT -e 'mirror -R $P_SOURCE $LFTP_TARGET; exit;'"
if [ "$LFTP_DEBUG" = "true" ]; then
    echo "source："${P_SOURCE}
    echo "cmd："${CMD}
fi
echo "uploading..."
eval $CMD

# 记录执行结束时间
end_time=$(date +%s%N)
end_ms=${end_time:0:16}

echo "All Done..."
echo "script use "$[end_ms - start_ms]" ms."
