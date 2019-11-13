# Formål
At sætte deltageren i stand til at anvende Docker i det daglige arbejde som enten udvikler eller devops.  
Kurset henvender sig til udvikleren, testeren og driftsmedarbejderen.

# Beskrivelse
Docker er et værktøj designet til at gøre det nemt at skabe, udrulle og køre applikationer i de såkaldte containere.   
Containere giver en udvikler/devops mulighed for at pakke en applikation samme med alle de dele som applikationen har brug for, f.eks. en mail-server, libraries, database.  
Det betyder at man er sikker på at applikationen kan køre uafhængig af hostens konfiguration.  
Samtidigt giver containere beskyttelse, da de enkle containere er adskilte på hosten.

# Videre forløb
  * SU-161 - Docker Videregående & Kubernetes

# Indhold 
## Introduktion til Docker
  * Hvad er Docker?
  * Hvilke problemer løser Docker?
  * Hvor og hvornår bruges Docker
  * Øvelser

## Generelt om software i containere
  * PID namespace
  * Eliminering meta-konflikter
  * Bygge 'environment-agnostic' systmer
  * Oprydning
  * Øvelser

## Arbejde med storage og volumer
  * Filtræer og mount-points
  * Blinde mounts
  * Hukommelsesbaseret storage
  * Docker volumes
  * Delte mount-points og deling af filer
  * Oprydning af volumes
  * Advanceret storage med volume plugins
  * Øvelser

## Single host networking
  * Netværk basisviden
  * Docker container netværk
  * Specielle container netværk: 'host' og 'none'
  * Håndtering af indkommende traffik med 'NodePort' publishering
  * Øvelser

## Begrænse risici med isolation
  * Begrænse resourcer
  * Delt hukommelse
  * Bruger i et Dockermiljø
  * Justere adgang til host OS'et med 'capabilities'
  * Kør en container med fuld rettigheder
  * Bygge 'use-case' tilpasset containere
  * Øvelser

## Pakke software med images
  * Bygge Docker images fra en container
  * Docker images og layers
  * Export/import 'flat file systems'
  * Versionering af images
  * Øvelser

## Offentlig og privat software distribution
  * Valg af en distributionsmetode
  * Publishere til 'hosted registries'
  * Introduktion til 'private registries'
  * Manual image publishering og distribution
  * Image source distribution workflows
  * Øvelser

## Image pipelines
  * Introduktion til begrebet 'image build pipelines'
  * Gem og opbevare metadata på 'image build time'
  * Testing af image i en 'build pipeline'
  * Tagging af images
  * Øvelser
