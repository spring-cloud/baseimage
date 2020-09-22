# springcloud/baseimage

Base Docker image for Spring Cloud Data Flow, Spring Cloud Skipper, Stream Applications and Tasks.

#### 1. Build the image

```
docker build -t springcloud/baseimage:<tag-version> . 
``` 

publish the image to DockerHub: 
```
docker push springcloud/baseimage:<tag-version> 
``` 


#### 2. Check the bundled JDK version

You can check the Java version bundled with a particular image tag, like this:

```
docker run -it --rm springcloud/openjdk:<image-tag> java -version
```

or by retrieving the `jdk-version` image label:

```
docker inspect springcloud/openjdk:<image-tag> | grep jdk-version
```
