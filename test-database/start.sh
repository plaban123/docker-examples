#!/bin/sh

echo "Starting DB..."

docker run --name dbtesting3 -d \
	-e MYSQL_ROOT_PASSWORD=123 \
	-e MYSQL_DATABASE=users -e MYSQL_USER=users_service -e MYSQL_PASSWORD=123 -p 3306:3306 \
	mysql:latest

echo "Waiting for db to start up.."

docker exec dbtesting3 mysqladmin --silent --wait=30 -uusers_service -p123 ping || exit 1

echo "SEtting up initial data ..."

docker exec -i dbtesting3 mysql -uusers_service -p123 users < setup.sql
