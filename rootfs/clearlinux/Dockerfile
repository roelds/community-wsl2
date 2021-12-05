FROM clearlinux:latest AS builder

ARG swupd_args

# Move to latest Clear Linux release
RUN swupd update --no-boot-update $swupd_args 
# Install clean os-core bundle in target directory
# using the new os version
RUN source /usr/lib/os-release; \
    kdir /install_root; \
    swupd os-install \
    --bundles=os-core-plus,binutils,which,cryptography,curl,make,jq,tmux,procps-ng,less \
    -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --no-boot-update; \
    cd /install_root/etc; \
    ln -s ../usr/lib/os-release os-release

FROM scratch
#
COPY --from=builder /install_root /
#

LABEL MAINTAINER="Bala Raman<srbala@gmail.com>"

RUN systemctl set-default multi-user.target; \
    systemctl mask systemd-remount-fs.service \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    systemd-logind.service \
    getty.target \
    console-getty.service \
    systemd-udev-trigger.service \
    systemd-udevd.service \
    systemd-random-seed.service \
    systemd-machine-id-commit.service
#
STOPSIGNAL SIGRTMIN+3
#
CMD ["/sbin/init"]
#
# build step: docker build --squash -t wsl-cl .
# run step  : docker run --rm -it wsl-cl /bin/bash
#