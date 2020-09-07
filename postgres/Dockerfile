FROM postgres:12.2

# 更换国内镜像源
COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y vim

# https://github.com/docker-library/postgres/tree/17c71aef1940ef0d2cc8bdc8bf7fb0a2856c8326/12
# 基于原镜像 docker-entrypoint.sh 做出来需更改权限
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && chmod 777 /docker-entrypoint.sh

# postgres 配置文件
COPY postgresql.conf /etc/postgresql/postgresql.conf
RUN chown -R postgres:postgres /etc/postgresql/postgresql.conf

# postgres 主节点配置脚本
COPY primary_deploy.sh /primary_deploy.sh
RUN chmod 777 /primary_deploy.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
