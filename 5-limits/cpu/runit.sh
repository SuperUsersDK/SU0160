#!/bin/bash

docker container run --cpu-shares 512

bruger@superusers:~/SU0160/5-limits/cpu$ cat runit.sh 
#!/bin/bash

if ! docker image ls | grep -q su0160/cpu-counter  
then
  docker build -t su0160/cpu-counter .  
fi

docker container run -d --cpu-shares  500   --name counter2    su0160/cpu-counter
docker container run -d --cpu-shares  250   --name counter1    su0160/cpu-counter
docker container run -d --cpus 0.75  --name counter3    su0160/cpu-counter
docker container run -d --cpuset-cpus 0 --name counter4a    su0160/cpu-counter
docker container run -d --cpuset-cpus 0,1 --name counter4b    su0160/cpu-counter
docker container run -d --cpuset-cpus 0-2 --name counter4c    su0160/cpu-counter
docker container run -d --cpuset-cpus 0 --name counter4d    su0160/cpu-counter

echo "Running for 60 seconds"
sleep 60

docker logs counter3 | tail -1
docker logs counter2 | tail -1 
docker logs counter1 | tail -1

docker container rm -f counter1 counter2 counter3 counter4a counter4b counter4c counter4d >/de
