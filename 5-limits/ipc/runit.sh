#!/bin/bash

if ! docker image ls | grep -q su0160/ipc
then
  docker build -t su0160/ipc .  
fi

echo "Without ipc options - not working"
echo "Running producer"
docker container run --name ipc_producer -d su0160/ipc -producer
sleep 5

echo "Running consumer"
docker container run --name ipc_consumer -d su0160/ipc -consumer
sleep 5

echo "Looking at the logs"
docker logs ipc_producer | tail
docker logs ipc_consumer | tail

echo "Removing containers"
docker container rm -f ipc_producer ipc_consumer
sleep 3

################

echo
echo "Running again"
echo "With IPC options - working"

echo "Running producer"
docker container run --ipc=shareable --name ipc_producer -d su0160/ipc -producer
sleep 5

echo "Running consumer"
docker container run --ipc=container:ipc_producer --name ipc_consumer -d su0160/ipc -consumer
sleep 5

echo "Looking at the logs"
docker logs ipc_producer | tail
docker logs ipc_consumer | tail

echo "Removing containers"
docker container rm -f ipc_producer ipc_consumer
sleep 3
