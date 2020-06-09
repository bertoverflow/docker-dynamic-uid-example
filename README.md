# docker-dynamic-uid-example

Example project to show how to use a dynamic uid when starting a container.
The docker run command has a `--user` parameter, but this has some limitations.
See here for a good article about the topic:
https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

This technique (at least similar) is also used in the official docker images (for example for redis):
https://github.com/docker-library/redis/tree/master/5.0

## Build the image
```shell script
docker build . -t docker-dynamic-uid-example
```

## Run the container

This will run the container with the uid of the host-user, so using volumes will not be a problem.
```shell script
docker run -it -e LOCAL_USER_ID=`id -u $USER` docker-dynamic-example bash
```



