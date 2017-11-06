#!/bin/bash

# Remove existing image named sdc-demo for development.
docker rm -f sdc-demo

# DO I NEED TO DO THIS WITH THE FROM in DOCKERFILE? Don't think so.
# Delete and retry.
# docker pull streamsets/datacollector


# Build image.
docker build -t sdc-demo .

# Run container and exec into bash shell as sdc user.
docker run --restart on-failure -p 18630:18630 -d --name sdc-demo sdc-demo
docker exec -u sdc -it sdc-demo bash

