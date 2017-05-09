#! /usr/bin/env bash

SOLR_RELEASE="6.4.0"
ITERATION="0.0.0"

OUTPUT_FILE="solr_${SOLR_RELEASE}-${ITERATION}_sysv_amd64.deb"

fpm -s dir \
  -p "$OUTPUT_FILE" \
  -t deb \
  -n solr \
  -v '6.4.0' \
  --iteration '0.0.0' \
  -d adduser \
  -d openjdk-8-jre \
  -m howard@howardtyson.com \
  --description 'A simple solr service packed for easy installation.'  \
  --before-install=scripts/before-install.sh  \
  --after-install=scripts/before-install.sh  \
  --before-remove=scripts/before-remove.sh \
  --deb-use-file-permissions \
  --deb-init /etc/init.d/solr \
  --deb-default /etc/defaults/solr.in.sh \
  --deb-use-file-permissions \
  /opt/solr
  /var/lib/solr
