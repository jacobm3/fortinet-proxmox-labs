#!/bin/bash

# Show existing bridges
echo "Existing bridges:"
ip link show type bridge


# Create Linux Bridges
PROJ_KEY=sdwan-bgp
BRIDGE_PREFIX=br_${PROJ_KEY}

cp /etc/network/interfaces /etc/network/interfaces.`date +%Y.%m.%d-%H.%M.%S`.bak
cat >> /etc/network/interfaces <<EOF

# Bridge naming convention: br_PROJECT_SITE

# BGP peer, ASN 64512
auto ${BRIDGE_PREFIX}_asn64512
iface ${BRIDGE_PREFIX}_asn64512 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094

# BGP peer, ASN 64513
auto ${BRIDGE_PREFIX}_asn64513
iface ${BRIDGE_PREFIX}_asn64513 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094

# FortiGate Hub 1
auto ${BRIDGE_PREFIX}_hub1
iface ${BRIDGE_PREFIX}_hub1 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094

# FortiGate Hub 2
auto ${BRIDGE_PREFIX}_hub2
iface ${BRIDGE_PREFIX}_hub2 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094
        
# FortiGate Branch 1
auto ${BRIDGE_PREFIX}_branch1
iface ${BRIDGE_PREFIX}_branch1 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094

# FortiGate Branch 2
auto ${BRIDGE_PREFIX}_branch2
iface ${BRIDGE_PREFIX}_branch2 inet static
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094


EOF
