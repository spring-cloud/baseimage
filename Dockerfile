ARG DOWNLOAD_URI=https://github.com/bell-sw/Liberica/releases/download/11.0.15+10/bellsoft-jre11.0.15+10-linux-amd64.tar.gz
ARG SHA1=a0cae6e964f67497840344c64614f13e530c43c8

# Download and verify file
# Args: $DOWNLOAD_URI, $SHA256
FROM ubuntu:bionic AS retrieve

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
 && rm -rf /var/lib/apt/lists/*

ARG DOWNLOAD_URI
RUN curl -L \
    $DOWNLOAD_URI \
    > download.tar.gz

ARG SHA1
RUN echo "${SHA1} download.tar.gz" | sha1sum -c - 2>&1

# Install File
FROM ubuntu:bionic

ENV JAVA_HOME /usr/lib/jvm/jre
ENV PATH $JAVA_HOME/bin:$PATH

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

RUN apt-get update && apt-get install --no-install-recommends -y wget

COPY --from=retrieve download.tar.gz /tmp/download.tar.gz

LABEL jdk.version=11.0.15-10

RUN mkdir -p /usr/lib/jvm \
 && tar xzf /tmp/download.tar.gz -C /usr/lib/jvm \
 && ln -s /usr/lib/jvm/* /usr/lib/jvm/jre \
 && rm /tmp/download.tar.gz

