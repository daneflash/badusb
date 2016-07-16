#!/bin/sh
#set -x
#set -e

ps -aef | grep "mitmdump"

echo "PID:"
read PID

sudo kill -9 $PID

ps -aef | grep "mitmdump"
