#!/bin/bash

BRIDGE_LIST="asn_64512 asn_64513 hub_1 hub_2 branch_1 branch_2"
PROJECT_PREFIX="Fortinet Lab SDWAN BGP route-map demo, "

# Show existing bridges
echo "Existing bridges:"
ip link show type bridge

cp /etc/network/interfaces /etc/network/interfaces.`date +%Y.%m.%d-%H.%M.%S`.bak

# Create Linux Bridges

counter=100

for bridge in $BRIDGE_LIST; do

cat >> /etc/network/interfaces <<EOF

auto vmbr${counter}
iface vmbr${counter} inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094
#${PROJECT_PREFIX} ${bridge}
EOF
    ((counter++))
done



# echo reloading interfaces
ifreload -a

counter=100

for bridge in $BRIDGE_LIST; do
  ifup vmbr${counter}
done

echo "Bridges after change:"
ip link show type bridge
