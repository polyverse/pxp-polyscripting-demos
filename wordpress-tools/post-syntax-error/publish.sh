#!/bin/bash

headsha=$(git rev-parse --verify HEAD)
docker build -t polyverse/syntax-error-poster:$headsha .
docker tag polyverse/syntax-error-poster:$headsha polyverse/syntax-error-poster:latest

if [[ "$1" == "-p" ]]; then
    docker push polyverse/syntax-error-poster:$headsha
    docker push polyverse/syntax-error-poster:latest
fi
