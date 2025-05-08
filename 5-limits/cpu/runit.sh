#!/bin/bash

if ! docker image ls | grep -q su0160/cpu-counter  
then
  docker build -t su0160/cpu-counter .  
fi

docker container run -d --cpu-shares  250   --name counter1    su0160/cpu-counter
docker container run -d --cpu-shares  500   --name counter2    su0160/cpu-counter
docker container run -d --cpu-shares  1000  --name counter3    su0160/cpu-counter
docker container run -d --cpu-shares  2000  --name counter4    su0160/cpu-counter

echo "Running for 60 seconds with '--cpu-shares'"
sleep 60

echo counter 1:  $(docker logs counter1 | tail -1)
echo counter 2:  $(docker logs counter2 | tail -1)
echo counter 3:  $(docker logs counter3 | tail -1)
echo counter 4:  $(docker logs counter4 | tail -1)

echo
echo Stopping containers
docker container rm -f counter1 counter2 counter3 counter4


docker container run -d --cpuset-cpus 0   --name counter5    su0160/cpu-counter
docker container run -d --cpuset-cpus 0,1 --name counter6    su0160/cpu-counter
docker container run -d --cpuset-cpus 0-2 --name counter7    su0160/cpu-counter
docker container run -d --cpuset-cpus 0-3 --name counter8    su0160/cpu-counter

echo
echo "Running for 60 seconds with '--cpus'"
sleep 60
echo counter 5:  $(docker logs counter5 | tail -1)
echo counter 6:  $(docker logs counter6 | tail -1)
echo counter 7:  $(docker logs counter7 | tail -1)
echo counter 8:  $(docker logs counter8 | tail -1)

echo
echo Stopping containers

docker container rm -f counter5 counter6 counter7 counter8
