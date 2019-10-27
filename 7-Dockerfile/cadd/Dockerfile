FROM szilvajuhos/cadd

RUN apt-get update 
RUN apt-get -y upgrade
RUN apt-get -y install unzip

WORKDIR /cadd-src
ADD https://github.com/kircherlab/CADD-scripts/archive/master.zip .
RUN unzip master.zip && rm master.zip

WORKDIR /cadd-src/CADD-scripts-master
COPY install-new.sh .

RUN ./install-new.sh




