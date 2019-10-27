#!/bin/sh

clear
echo "Running with 128M"
sleep 5
docker container run --memory=128M --rm su0160/calloc 
sleep 10

clear
echo "Running with 1G"
sleep 5
docker container run --memory=1G --rm su0160/calloc 
sleep 10
