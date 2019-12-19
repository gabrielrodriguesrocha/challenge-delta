FROM mysql:5.7

ENV MYSQL_DATABASE=packages \
    MYSQL_USER=user_packages \
    MYSQL_PASSWORD=passwords \
    MYSQL_ROOT_PASSWORD=passwords

COPY ./database_schema.sql /docker-entrypoint-initdb.d/
