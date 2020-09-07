#!/bin/bash

# 使用root用户执行命令
echo "root" | su - root /etc/init.d/ssh start

# 等主服务配置好
sleep 20s

PRIMARY_IP="172.80.0.2"
PGDATA="/var/lib/postgresql/replicate_data"

if [ ! "$(ls -A $PGDATA)" ];then
      export PGPASSWORD=secret && pg_basebackup -h $PRIMARY_IP -U replicator -p 5432 -D $PGDATA -Fp -Xs -P -R
fi


