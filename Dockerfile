FROM    openjdk:8-jre
MAINTAINER  Howard Tyson "howard@howradtyson.com"


# Override the solr download location with e.g.:
#   docker build -t mine --build-arg SOLR_DOWNLOAD_SERVER=http://www-eu.apache.org/dist/lucene/solr .
ARG SOLR_DOWNLOAD_SERVER

# Override the GPG keyserver with e.g.:
#   docker build -t mine --build-arg GPG_KEYSERVER=hkp://eu.pool.sks-keyservers.net .
ARG GPG_KEYSERVER

RUN apt-get update && \
  apt-get -y install build-essential ruby ruby-dev lsof && \
  rm -rf /var/lib/apt/lists/*

ENV SOLR_USER solr

ENV SOLR_KEY 478EEF7066AD843EC4812769707B7D9F6FDB8105
ENV GPG_KEYSERVER ${GPG_KEYSERVER:-hkp://ha.pool.sks-keyservers.net}
RUN gpg --keyserver "$GPG_KEYSERVER" --recv-keys "$SOLR_KEY"

ARG VERSION
ENV VERSION ${VERSION:-7.1}
ARG SOLR_VERSION=6.4.0
ENV SOLR_VERSION ${SOLR_VERSION}
ENV SOLR_SHA256 1213ae09023058ea1cbd971a1b585f891fb63fa76e128611031bfc28c749b502
ENV SOLR_URL ${SOLR_DOWNLOAD_SERVER:-https://archive.apache.org/dist/lucene/solr}/$SOLR_VERSION/solr-$SOLR_VERSION.tgz

RUN apt-get install -y ruby ruby-dev
RUN gem install fpm

RUN mkdir -p /var/lib/solr && mkdir -p /solr-scratch/solr
RUN env
RUN wget -nv $SOLR_URL -O /solr-scratch/solr-${SOLR_VERSION}.tgz
RUN tar -C /solr-scratch/solr --extract --file /solr-scratch/solr-${SOLR_VERSION}.tgz --strip-components=1
RUN /solr-scratch/solr/bin/install_solr_service.sh /solr-scratch/solr-${SOLR_VERSION}.tgz -d /var/lib/solr
WORKDIR /solr-scratch
