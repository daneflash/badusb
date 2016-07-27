#!/bin/sh
#set -x
#set -e

sudo iptables -F
sudo iptables -X

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

FILECOUNT=$(find /home/usbarmory/SniffedFiles/ -type f | wc -l)

sudo ip link set usb0 up

sudo tcpdump -s0 -i usb0 -w /home/usbarmory/SniffedFiles/tcpdump-Startup.dump &>/home/usbarmory/tcpdumponstartlog.txt &
#sudo ip link set usb0 up
sudo ip addr add 10.0.0.1/24 dev usb0
#sudo ip route add default via 10.0.0.2
