#! /usr/bin/env bash

#docker rm -f $(docker ps -aq)

docker image prune -f
docker build --rm=false -t solr:latest .
docker run --name build -d -iv${PWD}:/build solr:latest 
docker cp build:/solr-scratch/solr_6.4.0-0.0.0_amd64.deb .
