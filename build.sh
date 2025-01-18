#!/bin/bash

# Ensure Docker credentials are passed securely
echo $DOCKER_PASS | docker login -u $DOCKER_USERNAME --password-stdin

# Stopping existing container (if it exists)
docker stop react || true
docker rm react || true

# Building a Docker image
docker build -t react-ci/cd .

# Running a container from the created image
docker run -d -it --name react -p 80:80 react-ci/cd

# Tagging the image for DockerHub
docker tag react-ci/cd mohamedibrahimm01/react-app:ci-cd

# Pushing the image to DockerHub
docker push mohamedibrahimm01/react-app:ci-cd

