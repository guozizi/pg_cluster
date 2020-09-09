#!/bin/bash

# 等服务起来
sleep 10s  

STANDBY_IP="172.80.0.3"
PGDATA="/var/lib/postgresql/data"

# 判断是否已经为主从复制的状态
OUTPUT="$(psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='replicator'")"

if  [ "${OUTPUT}" != "1" ]; then
	# 创建用户
	psql -U postgres -c "CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'secret';"
	# 允许从数据库连接到master
	echo "host replication replicator $STANDBY_IP/16 md5" >> $PGDATA/pg_hba.conf
	# 重新加载配置
	psql -U postgres -c "select pg_reload_conf()"
fi
