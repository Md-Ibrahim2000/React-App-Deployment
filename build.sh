#!/bin/bash

# Login into DockerHub (ensure credentials are set in environment variables):
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASS"

# Stopping and removing existing container (if exists):
docker stop react || true
docker rm react || true

# Building the Docker image:
docker build -t mohamedibrahimm01/react-ci/cd .

# Running the container from the created image:
docker run -d -p 80:80 --name react mohamedibrahimm01/react-ci/cd

# Tagging the image (with the proper format for DockerHub):
docker tag mohamedibrahimm01/react-ci/cd mohamedibrahimm01/react-app:ci-cd

# Pushing the image to DockerHub:
docker push mohamedibrahimm01/react-app:ci-cd
