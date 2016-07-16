#!/bin/sh
#set -x
#set -e

echo "Enter 's' for set up and 'd' for shut down > "
read action

if [ $action = "s" ]; then
	echo "Set Up..."
	ifconfig
	./route.sh
elif [ $action = "d" ]; then
	echo "Shut Down..."
	./delAllDef.sh
else
	echo "Invalid Command!"
fi
