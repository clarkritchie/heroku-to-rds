#!/usr/bin/env bash
mkdir -p ./data

docker build -f Dockerfile.dump -t blueboard:dump .
# docker run -w /dump --env-file env -i heroku:dump bash
docker run -w /dump -v ./data:/data -i blueboard:dump bash
