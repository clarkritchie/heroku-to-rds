#!/usr/bin/env bash
mkdir -p ./data

docker build -f Dockerfile.dump -t blueboard:dump .
docker run --name dump -w /dump -v ./data:/data -i blueboard:dump bash
