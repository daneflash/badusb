#!/bin/sh
#set -x
#set -e

ifconfig
#echo "Enter device name > "
#read device
export device=$(ls /sys/class/net | grep -E 'enx')

# bring the USB virtual Ethernet interface up
#sudo /sbin/ip link set usb0 up
sudo /sbin/ip link set $device up

# set the host IP address
#sudo /sbin/ip addr add 10.0.0.2/24 dev usb0
sudo /sbin/ip addr add 10.0.0.2/24 dev $device

# enable masquerading for outgoing connections towards wireless interface
sudo /sbin/iptables -t nat -A POSTROUTING -s 10.0.0.1/32 -o enp0s3 -j MASQUERADE

# enable IP forwarding
echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward

ssh usbarmory:usbarmory@10.0.0.1
#ssh root:toor@10.0.0.1
# TODO: Passwort anpassen!!!!
