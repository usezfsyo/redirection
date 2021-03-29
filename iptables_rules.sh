#!/bin/bash

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
wg_client=$(grep '/32' /etc/wireguard/wg0.conf | awk '{print $3}' | cut -d '/' -f 1)
wg_port=$(grep 'ListenPort' /etc/wireguard/wg0.conf | awk '{print $3}')
wg_server=$(grep 'Address' /etc/wireguard/wg0.conf | awk '{print $3}')

/sbin/iptables -t nat -F POSTROUTING
/sbin/iptables -t nat -F PREROUTING
/sbin/iptables -t nat -A PREROUTING -d $ip4 -p tcp ! --dport 22 -j DNAT --to-destination $wg_client
/sbin/iptables -t nat -A PREROUTING -d $ip4 -p udp ! --dport $wg_port -j DNAT --to-destination $wg_client
/sbin/iptables -t nat -A POSTROUTING -s $wg_server -j MASQUERADE
