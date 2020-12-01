#!/bin/sh

sudo iptables --policy INPUT   ACCEPT; sudo iptables --policy OUTPUT  ACCEPT; sudo iptables --policy FORWARD ACCEPT
sudo iptables -Z; sudo iptables -F; sudo iptables -X

sudo ip6tables --policy INPUT   ACCEPT; sudo ip6tables --policy OUTPUT  ACCEPT; sudo ip6tables --policy FORWARD ACCEPT
sudo ip6tables -Z; sudo ip6tables -F; sudo ip6tables -X

