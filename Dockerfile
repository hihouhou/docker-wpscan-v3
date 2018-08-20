#
# Wpscan-v3 Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

# Update & install packages for wpscan
RUN apt-get update && \
    apt-get install -y gcc git ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev procps

#Clone repository
RUN git clone https://github.com/wpscanteam/wpscan-v3.git

WORKDIR /wpscan-v3

#Install bundler
RUN gem install bundler

#Copy config file
RUN bundle install && rake install

CMD /wpscan-v3/bin/wpscan -f json --update --url $URL
