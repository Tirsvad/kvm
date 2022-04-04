#!/bin/bash

# Configuration
OS_PATH_INSTALLATION="https://deb.debian.org/debian/dists/bullseye/main/installer-amd64/"
QCOW2_FILENAME="debian11-minimal.qcow2"

source ./config.sh
# End Configuration

virsh net-start default
[[ ! -d debian11-minimal.qcow2 ]] && mkdir -p $QCOW2_PATH
cd $QCOW2_PATH

[[ ! -f debian11-minimal.qcow2 ]] && qemu-img create -f qcow2 -o preallocation=off /srv/kvm/debian11-minimal.qcow2 10G

virt-install \
--connect qemu:///system \
--virt-type qemu \
--name=debian11-minimal \
--location $OS_PATH_INSTALLATION \
--disk $QCOW2_PATH$QCOW2_FILENAME \
--vcpus 2 \
--memory 2048 \
--network default,mac=52:54:00:6c:3c:01 \
--graphics none \
--console pty,target_type=serial \
--os-type=Linux \
--os-variant=debian10 \
--extra-args 'console=ttyS0,115200n8 serial'
