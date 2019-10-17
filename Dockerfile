ARG DOWNLOAD_URI=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jre_x64_linux_hotspot_11.0.4_11.tar.gz
ARG SHA256=70d2cc675155476f1d8516a7ae6729d44681e4fad5a6fc8dfa65cab36a67b7e0

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

ENV JAVA_HOME /opt/java/openjdk
ENV PATH $JAVA_HOME/bin:$PATH

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

COPY --from=retrieve download.tar.gz /tmp/download.tar.gz

RUN mkdir -p $JAVA_HOME \
 && cd $JAVA_HOME \
 && tar xzf /tmp/download.tar.gz --strip-components=1 \
 && rm /tmp/download.tar.gz
