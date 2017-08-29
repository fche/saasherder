#!/bin/bash

set -xe

yum -y install docker

sed -i "s#\#?OPTIONS='--log-driver=journald'#OPTIONS='--log-driver=journald --insecure-registry 172.30.0.0/16'#" /etc/sysconfig/docker
cat /etc/sysconfig/docker

systemctl start docker

docker build -t saasherder-test -f tests/Dockerfile.test .
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock  --privileged --net=host saasherder-test
