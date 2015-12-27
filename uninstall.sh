#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

ISROOT=`id -u`
if [ $ISROOT -ne 0 ]; then
	printf "${RED}Run uninstall.sh by root.${NC}\n"
	exit 1
fi

DIR="/usr/local/ddos-deflate"
CRONFILE="/etc/cron.d/ddos-deflate"
LOGFILE="/var/log/ddos-deflate.log"

printf "${RED}Uninstalling DDoS-Deflate.\n"
if [ -d $DIR ]; then
	printf "Removing $DIR.\n"
	sleep 0.5
	rm -rf $DIR
fi

if [ -e $CRONFILE ]; then
	printf "Removing $CRONFILE.\n"
	sleep 0.5
	rm -f $CRONFILE
fi

if [ -e $LOGFILE ]; then
	printf "Removing $LOGFILE.\n"
	sleep 0.5
	rm -f $LOGFILE
fi

printf "Uninstallation has been completed.${NC}\n"
