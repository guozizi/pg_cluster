From postdock/pgpool:latest

COPY sources.list /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y vim \
    && apt-get install -y openssh-server

# postgres用户ssh免密
RUN mkdir -p /home/postgres/.ssh/

COPY id_rsa  /home/postgres/.ssh/id_rsa
COPY id_rsa.pub /home/postgres/.ssh/id_rsa.pub
COPY sshd_config /etc/ssh/sshd_config 

RUN chown -R postgres:postgres /home/postgres/.ssh
RUN chmod 600 /home/postgres/.ssh/id_rsa

# 将failover_command设置为evn变量
COPY pgpool_setup.sh /usr/local/bin/pgpool/pgpool_setup.sh

# 配置failover脚本（主节点下线从节点升为主节点）
COPY failover.sh /usr/local/etc/failover.sh
RUN chmod 777 /usr/local/etc/failover.sh

RUN mkdir /run/sshd
CMD /etc/init.d/ssh start && bash /usr/local/bin/pgpool/entrypoint.sh

