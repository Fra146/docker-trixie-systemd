FROM python:3.11-trixie

# Install systemd and clean up
RUN apt-get update && apt-get install -y \
    systemd \
    systemd-sysv \
    dbus \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN systemctl mask \
    sys-kernel-debug.mount \
    sys-kernel-tracing.mount \
    systemd-modules-load.service \
    systemd-udev-control.socket \
    systemd-udev-trigger.service \
    systemd-udevd-kernel.socket \
    systemd-udevd.service

# Tell systemd we are in a container
ENV container docker

# Systemd expects the "stop" signal to be SIGRTMIN+3
STOPSIGNAL SIGRTMIN+3

# Start systemd as the entrypoint
CMD ["/lib/systemd/systemd"]
