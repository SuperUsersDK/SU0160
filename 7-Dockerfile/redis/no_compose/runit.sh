#!/bin/bash

cd db
docker container run -d -v redis.conf:/usr/local/etc/redis/redis.conf \
	                -v /home/bruger/redisdb/:/redis/              \
		        --network app-network                         \
			--name db                                     \
	redis redis-server /usr/local/etc/redis/redis.conf --requirepass reganvest
cd ..

cd app
docker container run -d --network app-network --name mega_app redis_app
cd ..
