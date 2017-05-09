#! /usr/bin/env bash

fpm -s dir \
  -t deb \
  -n solr \
  -v '6.4.0' \
  --iteration '0.0.0' \
  -d adduser \
  -m howard@howardtyson.com \
  --description 'A simple solr service packed for easy installation.'  \
  --before-install=scripts/before-install.sh  \
  --after-install=scripts/before-install.sh  \
  --before-remove=scripts/before-remove.sh \
  --deb-use-file-permissions \
  --deb-init init.d/solr \
  --deb-default defaults/solr.in.sh \
  build/opt/solr/=opt/solr
