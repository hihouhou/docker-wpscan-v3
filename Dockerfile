#
# Wpscan-v3 Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV WPSCAN_V3_VERSION v3.7.2

# Update & install packages for wpscan
RUN apt-get update && \
    apt-get install -y gnupg2 gcc wget libcurl4-openssl-dev make zlib1g-dev procps libxslt-dev libxml2-dev curl g++ autoconf automake bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev

RUN gpg2 --keyserver ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable

RUN /bin/bash -c "source /etc/profile.d/rvm.sh && \
    rvm install 2.5.1 && \
    rvm use 2.5.1 --default"

#Fetch repository
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && \mkdir wpscan-v3 && \
    cd wpscan-v3 && \
    wget https://api.github.com/repos/wpscanteam/wpscan/tarball/${WPSCAN_V3_VERSION} -O ${WPSCAN_V3_VERSION}.tar.gz && \
    tar xf  ${WPSCAN_V3_VERSION}.tar.gz --strip-components=1 && \
    gem install bundler && \
    gem install pkg-config && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install && \
    rake install"

CMD /bin/bash -c "source /etc/profile.d/rvm.sh && /wpscan-v3/bin/wpscan -f json --update --url $URL"
