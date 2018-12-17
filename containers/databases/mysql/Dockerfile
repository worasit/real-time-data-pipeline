FROM mysql:5.7
COPY config/mysql.cnf /etc/mysql/conf.d/
COPY config/inventory.sql /docker-entrypoint-initdb.d/
ADD VERSION .