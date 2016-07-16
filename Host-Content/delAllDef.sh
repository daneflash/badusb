#!/bin/sh
#set -x
#set -e

#delete all rules and defines
echo "Clear ip rules..."
while sudo ip rule delete from 0/0 to 0/0 fwmark 0x1 2>/dev/null; do true; done
while sudo ip rule delete from 0/0 to 0/0 fwmark 0x2 2>/dev/null; do true; done
sudo ip route del default table arm-route
sudo ip route del 10.0.0.0/24 table arm-route
sudo ip route del default table normal

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X

#echo "Clear mangle OUTPUT..."
#while sudo iptables -t mangle -D OUTPUT 1 2>/dev/null; do true; done
#echo "Clear mangle PREROUTING..."
#while sudo iptables -t mangle -D PREROUTING 1 2>/dev/null; do true; done
#echo "Clear mangle INPUT..."
#while sudo iptables -t mangle -D INPUT 1 2>/dev/null; do true; done
#echo "Clear mangle POSTROUTING..."
#while sudo iptables -t mangle -D POSTROUTING 1 2>/dev/null; do true; done
#echo "Clear NAT POSTROUTING..."
#while sudo iptables -t nat -D POSTROUTING 1 2>/dev/null; do true; done
#echo "Clear NAT PREROUTING..."
#while sudo iptables -t nat -D PREROUTING 1 2>/dev/null; do true; done

# show info of defined routes
./showInfo.sh
