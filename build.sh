#!/bin/bash

# Login into DockerHub:
docker login -u $DOCKER_USERNAME -p $DOCKER_PASS

# Stopping existing container:
docker stop react
docker rm react

# Building the image:
docker build -t react-ci/cd .

# Running a container from the created image:
docker run -d -it --name react -p 80:80 react-ci/cd

# Pushing the image to DockerHub:
docker tag react-ci/cd mohamedibrahimm01/react-app:ci-cd
docker push mohamedibrahimm01/react-app:ci-cd

