#!/bin/bash

virsh net-start default
mkdir -p /srv/kvm
cd /srv/kvm
virt-install \
--connect qemu:///system \
--virt-type qemu \
--name=debian11-minimal \
--location https://deb.debian.org/debian/dists/bullseye/main/installer-amd64/ \
--disk /srv/kvm/debian11-minimal.qcow2 \
--vcpus 2 \
--memory 2048 \
--network default,mac=52:54:00:6c:3c:01 \
--graphics spice \
--os-type=Linux \
--os-variant=debian10
