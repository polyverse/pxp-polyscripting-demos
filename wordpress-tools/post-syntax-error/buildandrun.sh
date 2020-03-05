#!/bin/bash


./publish.sh

headsha=$(git rev-parse --verify HEAD)
docker run --name wordpress -e "DEBUG=true" -e "MODE=$1" -e "WP_SLUG=localhost:8080" --rm -it -p 8080:8080 polyverse/syntax-error-poster:$headsha

