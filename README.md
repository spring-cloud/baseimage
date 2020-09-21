# openjdk-docker

OpenJDK Docker image

#### Retrieve the JDK version

You can check the Java version bundled with a particular image tag, like this:

```
docker run -it --rm springcloud/openjdk:<image-tag> java -version
```

or by retrieving the `jdk-version` image label:

```
docker inspect springcloud/openjdk:<image-tag> | grep jdk-version
```
