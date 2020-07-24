#!/usr/bin/env bash

docker build -t dotfiles:latest .
docker run -it --rm -v $(pwd)/.:/tmp/test dotfiles:latest
