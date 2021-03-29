#!/bin/bash

server_key=$(wg genkey)
server_pubkey=$(echo $server_key | wg pubkey)

client_key=$(wg genkey)
client_pubkey=$(echo $client_key | wg pubkey)

server_ip=$(curl -s ipinfo.io | grep \"ip\" | awk '{print $2}' | sed s/\"//g | sed s/,//g)

echo "[Interface]
Address = 10.0.41.1/24
PrivateKey = $server_key
ListenPort = 51820

[Peer]
PublicKey = $client_pubkey
AllowedIPs = 10.0.41.2/32" > /etc/wireguard/wg0.conf

echo "[Interface]
Address = 10.0.41.2/24
PrivateKey = $client_key

[Peer]
Endpoint = $server_ip:51820
PublicKey = $server_pubkey
PersistentKeepalive = 30
AllowedIPs = 0.0.0.0/0" > /root/wg0_client.conf


