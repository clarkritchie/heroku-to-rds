#!/usr/bin/env bash

docker build -f Dockerfile.restore -t blueboard:restore .
docker run --name restore -d -v ./data:/data -i blueboard:restore bash
