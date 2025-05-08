#!/bin/sh

if ! docker image ls | grep -q su0160/calloc
then
  docker build -t su0160/calloc .
fi

clear
echo "Running with 128M"
sleep 2
docker container run --memory=128M --rm su0160/calloc 
sleep 5

clear
echo "Running with 1G"
sleep 2
docker container run --memory=1G --rm su0160/calloc 
sleep 5
