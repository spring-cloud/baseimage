ARG DOWNLOAD_URI=https://github.com/bell-sw/Liberica/releases/download/11.0.8+10/bellsoft-jre11.0.8+10-linux-amd64.tar.gz
ARG SHA256=b4cb31162ff6d7926dd09e21551fa745fa3ae1758c25148b48dadcf78ab0c24c

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

ARG SHA256
RUN echo "${SHA256} download.tar.gz" | sha256sum -c - 2>&1

# Install File
FROM ubuntu:bionic

ENV JAVA_HOME /usr/lib/jvm/jre
ENV PATH $JAVA_HOME/bin:$PATH

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

COPY --from=retrieve download.tar.gz /tmp/download.tar.gz

RUN mkdir -p /usr/lib/jvm \
 && tar xzf /tmp/download.tar.gz -C /usr/lib/jvm \
 && ln -s /usr/lib/jvm/* /usr/lib/jvm/jre \
 && rm /tmp/download.tar.gz

