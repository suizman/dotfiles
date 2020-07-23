FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

RUN apt-get update -qq &&      \
    apt-get install -qq -y     \
    vim nodejs fish curl git

CMD ["/bin/bash"] 
