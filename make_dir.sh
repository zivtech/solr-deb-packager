#! /usr/bin/env bash

mkdir -p /package/var/lib
mkdir -p /package/opt
cp -ra /opt/solr/ /package/opt
cp -ra /var/lib/solr/ /package/var/lib

mkdir /build
#mkdir /build/opt
#mkdir /build/opt/solr
