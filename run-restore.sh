#!/usr/bin/env bash

docker build -f Dockerfile.restore -t blueboard:restore .
docker run -w /dump -v ./data:/data -i blueboard:restore bash
