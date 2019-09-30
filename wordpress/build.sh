#!/bin/sh

image="wordpress-demo"

docker build -t $image . --no-cache
