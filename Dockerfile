#
# Wpscan-v3 Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV WPSCAN_V3_VERSION v3.3.2

# Update & install packages for wpscan
RUN apt-get update && \
    apt-get install -y gcc wget ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev procps libxslt-dev libxml2-dev

#Fetch repository
RUN mkdir wpscan-v3 && \
    cd wpscan-v3 && \
    wget https://api.github.com/repos/wpscanteam/wpscan/tarball/${WPSCAN_V3_VERSION} -O ${WPSCAN_V3_VERSION}.tar.gz && \
    tar xf  ${WPSCAN_V3_VERSION}.tar.gz --strip-components=1 && \
    gem install bundler && \
    gem install pkg-config && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install && \
    rake install

CMD /wpscan-v3/bin/wpscan -f json --update --url $URL
