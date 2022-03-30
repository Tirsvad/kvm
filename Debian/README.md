# Debian

## Debian minimal

### Create varible size disk

    qemu-img create -f qcow2 -o preallocation=off /srv/kvm/debian11-minimal.qcow2 10G

### Create KVM image

    bash create-debian11-minimal.sh
