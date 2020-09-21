# Base Image

A base image used for building images of executable components:  
  * Spring Cloud Data Flow
  * Spring Cloud Skipper
  * Stream Applications
  * Task Applications

Includes Java 11+, and some common utilities

#### Retrieve the JDK version

You can check the Java version bundled with a particular image tag, like this:

```
docker run -it --rm springcloud/baseimage:<image-tag> java -version
```

or by retrieving the `jdk-version` image label:

```
docker inspect springcloud/openjdk:<image-tag> | grep jdk-version
```
