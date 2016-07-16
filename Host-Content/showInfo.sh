#!/bin/sh
#set -x
#set -e

# show info of defined routes
echo "\n"
echo "Defined rules:"
echo "-------------------------------------"
sudo ip rule show
echo "-------------------------------------"
echo "\n"

echo "Defines for mangle:"
echo "-------------------------------------"
sudo iptables -t mangle -L
echo "-------------------------------------"
echo "\n"

echo "Defines for nat:"
echo "-------------------------------------"
sudo iptables -t nat -L
echo "-------------------------------------"
echo "\n"

echo "Defined arm route:"
echo "-------------------------------------"
sudo ip route show table arm-route
#sudo ip route show table default
echo "-------------------------------------"

echo "Routing table:"
echo "-------------------------------------"
sudo route
echo "-------------------------------------"
