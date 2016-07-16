#!/bin/sh
#set -x
#set -e

sudo iptables -I INPUT 1 -p icmp -j LOG --log-prefix="FILTER-INPUT: " --log-level 7
sudo iptables -I OUTPUT 1 -p icmp -j LOG --log-prefix="FILTER-OUTPUT: " --log-level 7
sudo iptables -I FORWARD 1 -p icmp -j LOG --log-prefix="FILTER-FORWARD: " --log-level 7

sudo iptables -t nat -I PREROUTING 1 -p icmp -j LOG --log-prefix="NAT-PREROUTING: " --log-level 7
sudo iptables -t nat -I POSTROUTING 1 -p icmp -j LOG --log-prefix="NAT-POSTROUTING: " --log-level 7
sudo iptables -t nat -I OUTPUT 1 -p icmp -j LOG --log-prefix="NAT-OUT: " --log-level 7
sudo iptables -t nat -I INPUT 1 -p icmp -j LOG --log-prefix="NAT-IN: " --log-level 7

sudo iptables -t mangle -I PREROUTING 1 -p icmp -j LOG --log-prefix="MANGLE-PREROUTING: " --log-level 7
sudo iptables -t mangle -I FORWARD 1 -p icmp -j LOG --log-prefix="MANGLE-FORWARD: " --log-level 7
sudo iptables -t mangle -I INPUT 1 -p icmp -j LOG --log-prefix="MANGLE-INPUT: " --log-level 7
sudo iptables -t mangle -I POSTROUTING 1 -p icmp -j LOG --log-prefix="MANGLE-POSTROUTING: " --log-level 7
sudo iptables -t mangle -I OUTPUT 1 -p icmp -j LOG --log-prefix="MANGLE-OUT: " --log-level 7
