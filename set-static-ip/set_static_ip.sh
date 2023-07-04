#!/bin/bash
NETWORK=$(ip r | awk '/^def/{print $7}')
NETWORK_TYPE=$(ip r | awk '/^def/{print $5}')
IP=$(ip r | awk '/^def/{print $9}')
GATEWAY=$(ip r | awk '/^def/{print $3}')
NAMESERVER=$(cat /run/systemd/resolve/resolv.conf | awk '/^nameserver/{print $2}')

if [ "$NETWORK" == "dhcp" ];
then
  echo "dhcp"
  cat <<EOF >/etc/netplan/00-installer-config.yaml
# This is the network config written by 'subiquity'
network:
  renderer: networkd
  ethernets:
    $NETWORK_TYPE:
      dhcp4: no
      addresses: [$IP/16]
      gateway4: $GATEWAY
      nameservers:
        addresses: [$NAMESERVER]
  version: 2
EOF

else
  echo "Already static IP is present"
fi 
