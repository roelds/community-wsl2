ARG SYSBASE=amazonlinux:2

FROM ${SYSBASE} AS system-build

RUN yum install -y \
    bash \
    binutils \
    coreutils \
    coreutils-common \
    crypto-policies-scripts \
    dbus-glib \
    diffutils \
    dmidecode \
    yum-plugins-core \
    elfutils-debuginfod-client \
    file \
    findutils \
    glibc-minimal-langpack \
    gzip \
    hwdata \
    iptables-libs \
    iputils \
    jq \
    langpacks-en \
    less \
    libibverbs \
    libmetalink \
    libnl3 \
    libpcap \
    libuser \
    make \
    nano \    
    ncurses \
    openssl \
    openssl-pkcs11 \
    passwd \
    pciutils \
    pciutils-libs \
    platform-python-pip \
    procps-ng \ 
    python3-dateutil \
    python3-dbus \
    python3-yum-plugins-core \
    python3-six \
    python3-unbound \
    rdma-core \
    rootfiles \
    #    rpm-plugin-systemd-inhibit \
    rsyslog \
    sudo \
    systemd \
    tar \
    #    tmux \
    unbound-libs \
    usermode \
    vim-minimal \
    virt-what \
    which \
    wget \
    xz \
    yum \
    yum-utils;\
    yum clean all; \
    rm -rf /var/cache/* /var/log/yum* /var/log/yum.*; \
    # cp /etc/yum.repos.d/*.repo /etc/yum.repos.d/; \
    # generate build time file for compatibility with CentOS
    /bin/date +%Y%m%d_%H%M > /etc/BUILDTIME; \
    echo '%_install_langs C.utf8' > /etc/rpm/macros.image-language-conf; \
    echo 'LANG="C.utf8"' >  /etc/locale.conf; \
    echo 'container' > /etc/yum/vars/infra; \
    echo 'PS1="\[\e[m\][\[\e[m\]\[\e[35m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[m\]]\[\e[m\]\\$ "' >> /etc/profile.d/sh.local; \
    echo 'LANG="C.utf8"' >> /etc/profile.d/sh.local; \
    rm -f /etc/machine-id; \
    touch /etc/machine-id;

COPY scripts/ /

FROM scratch AS system-build2

COPY --from=system-build / /

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

FROM scratch 

COPY --from=system-build2 . .

ENV LANG=C.utf8 

LABEL MAINTAINER="Bala Raman<srbala@gmail.com>"

STOPSIGNAL SIGRTMIN+3
#
CMD ["/sbin/init"]
#
# build image step       : docker build --squash -t srbala/wsl:alma-amd64 .
# test & local run step  : docker run --rm -it srbala/wsl:alma-amd64 /bin/bash
#
# build image step       : docker build --squash --platform linux/arm64 -t srbala/wsl:alma-arm64 .
# test & local run step  : docker run --rm -it srbala/wsl:alma-arm64 /bin/bash
#