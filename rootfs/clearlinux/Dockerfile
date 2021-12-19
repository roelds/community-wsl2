FROM clearlinux:latest AS builder

# Move to latest Clear Linux release
RUN swupd update --no-boot-update; \
    swupd bundle-add sysadmin-basic; 
RUN swupd bundle-add binutils; \
    swupd bundle-add jq; \
    systemctl set-default multi-user.target; \
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
RUN cat /usr/lib/os-release | grep PRETTY_NAME | awk -F= '{print $2;}' | awk '{ gsub(/"/, ""); print }' > /etc/system-release ; 
#
COPY scripts/usr/local/ /usr/local
#ß
FROM scratch
COPY --from=builder / /
CMD ["/bin/bash"]