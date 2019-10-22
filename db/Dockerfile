FROM mariadb:latest

ENV MYSQL_USER=beaker \
      MYSQL_PASSWORD=beaker \
      MYSQL_ALLOW_EMPTY_PASSWORD=yes

COPY ./my.cnf /etc/mysql/my.cnf
RUN chown root.root /etc/mysql/my.cnf && chmod 0644 /etc/mysql/my.cnf

RUN echo "CREATE DATABASE IF NOT EXISTS beaker; GRANT ALL PRIVILEGES ON beaker.* TO 'beaker'@'%';" > /docker-entrypoint-initdb.d/init.sql; \
      echo "CREATE DATABASE IF NOT EXISTS beaker_test; GRANT ALL PRIVILEGES ON beaker_test.* TO 'beaker'@'%';" >> /docker-entrypoint-initdb.d/init.sql; \
      echo "CREATE DATABASE IF NOT EXISTS beaker_migration_test; GRANT ALL PRIVILEGES ON beaker_migration_test.* TO 'beaker'@'%';" >> /docker-entrypoint-initdb.d/init.sql;
