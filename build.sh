#!/bin/bash -e
# description: Run `almalinux/ks2rootfs` image using docker
# license: MIT.
docker run --rm --privileged -v "$PWD:/build:z" \
    -e KICKSTART_FILE=kickstarts/almalinux-8-wsl.ks \
    -e IMAGE_NAME=almalinux-8-docker-wsl.tar.gz \
    -e OUTPUT_DIR=work/wsl \
    -e BUILD_TYPE=wsl \
    almalinux/ks2rootfs