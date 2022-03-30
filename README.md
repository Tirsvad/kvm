# KVM

## Installing KVM

### Debian

    sudo apt -qq install qemu qemu-kvm qemu-system qemu-utils
    sudo apt -qq install libvirt-clients libvirt-daemon-system virtinst
    sudo systemctl start libvirtd
    sudo virsh net-define /usr/share/libvirt/networks/default.xml # default
    sudo virsh net-start default
    sudo virsh net-autostart default

optional

    apt install net-tools


## Create new default network

    bash create-network-bridge-default.sh
