FROM ubuntu:bionic

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    netcat \
    wget \
 && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /opt/openjdk
ENV PATH $JAVA_HOME/bin:$PATH

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

WORKDIR /opt/openjdk
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl https://java-buildpack.cloudfoundry.org/openjdk/bionic/x86_64/openjdk-1.8.0_192.tar.gz | tar xz
