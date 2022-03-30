#!/bin/bash

vm_bridge="virbr0"

vm_network=$(virsh net-list --name 2>&1 | head -n 1)

if [ "$vm_network" = "" ]; then
    vm_network="default"
else
    sudo virsh net-destroy $vm_network
    sudo virsh net-undefine $vm_network
fi

cat >/tmp/virsh_network.xml <<__EOF
<network>
    <name>$vm_network</name>
    <uuid>530f11c4-617b-447c-bdba-704f34374277</uuid>
    <bridge name='$vm_bridge' stp='on' delay='0'/>
    <mac address='52:54:00:6c:3c:00'/>
    <ip address='192.168.122.1' netmask='255.255.255.0'>
        <dhcp>
            <range start='192.168.122.2' end='192.168.122.254'/>
            <host mac='52:54:00:6c:3c:01' name='debian11-minimal' ip='192.168.122.11'/>
            <host mac='52:54:00:6c:3c:02' name='vm2' ip='192.168.122.12'/>
            <host mac='52:54:00:6c:3c:03' name='vm3' ip='192.168.122.13'/>
        </dhcp>
    </ip>
</network>
__EOF

nft insert rule ip filter LIBVIRT_INP iifname "$vm_bridge" tcp dport 67 counter accept

sudo virsh net-define /tmp/virsh_network.xml
sudo virsh net-autostart $vm_network
sudo virsh net-start $vm_network

rm -f /tmp/virsh_network.xml
