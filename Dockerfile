FROM ubuntu:xenial

# Install Prerequisites
RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang git make gcc libc-dev ca-certificates

# Setup Bridge
ADD . /bridge-src
RUN \
  cd /bridge-src && make bridge && \
  cp /bridge-src/build/bridge /bridge

# Cleanup
RUN \
  apt-get remove -y golang git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /bridge-src
