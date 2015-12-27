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

if [ ! -d '$DIR' ] && [ ! -e '$CRONFILE' ] && [ ! -e '$LOGFILE' ] ; then
	printf "${RED}DDoS-Deflate already uninstalled.${NC}\n"
	exit 0
fi

printf "${RED}Uninstalling DDoS-Deflate.\n"
if [ -d '$DIR' ]; then
	printf "Removal script files...\n"
	sleep 0.5
	rm -rf $DIR
fi

if [ -e '$CRONFILE' ]; then
	printf "Removal cronjob...\n"
	sleep 0.5
	rm -f $CRONFILE
fi

if [ -e '$LOGFILE' ]; then
	printf "Removal ddos-deflate.log...\n"
	sleep 0.5
	rm -f $LOGFILE
fi

printf "Uninstall completed.${NC}\n"
