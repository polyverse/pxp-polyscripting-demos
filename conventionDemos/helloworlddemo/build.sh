#!/bin/sh

image="helloworlddemo"

echo "$(date) Obtaining current git sha for tagging the docker image"


docker build -t $image . --no-cache 
