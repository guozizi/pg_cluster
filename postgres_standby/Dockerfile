FROM postgres:12.2

# 更换国内镜像源
COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y vim \
    && apt-get install -y openssh-server

# ssh 免密
RUN mkdir /root/.ssh/ \
    &&touch /root/.ssh/authorized_keys

COPY id_rsa  /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY sshd_config /etc/ssh/sshd_config

COPY id_rsa.pub.pgpool  /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys


# https://github.com/docker-library/postgres/tree/17c71aef1940ef0d2cc8bdc8bf7fb0a2856c8326/12
# 基于原镜像 docker-entrypoint.sh 做出来需更改权限
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && chmod 777 /docker-entrypoint.sh

# 创建postgres data目录
RUN mkdir /var/lib/postgresql/replicate_data
RUN chmod 777 /var/lib/postgresql/replicate_data

# postgres 配置文件
COPY postgresql.conf /etc/postgresql/postgresql.conf
RUN chown -R postgres:postgres /etc/postgresql/postgresql.conf

# postgres 从节点配置脚本
COPY standby_deploy.sh /standby_deploy.sh
RUN chmod 777 /standby_deploy.sh

# 设置root密码为"root"
RUN echo "root:root" | chpasswd

EXPOSE 5432

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]
