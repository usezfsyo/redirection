# redirection

Requires an Ubuntu 20.04 cloud-based instance, and ansible on the local side. 
Create [redirectors] group in /etc/ansible/hosts and add public IP of cloud instance.

Once deployed, copy wireguard config from wg0.conf/ directory to /etc/wireguard/wg0.conf - start with ```wg-quick up wg0```
