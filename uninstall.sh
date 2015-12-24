#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

ISROOT=`id -u`
if [ $ISROOT -ne 0 ]; then
	printf "${RED}Run uninstall.sh by root.${NC}\n"
	exit 1
fi

if [ ! -d '/usr/local/ddos-deflate' ] && [ ! -e '/etc/cron.d/ddos-deflate' ]; then
	printf "${RED}DDoS-Deflate already uninstalled.${NC}\n"
	exit 0
fi

printf "${RED}Uninstalling DDoS-Deflate.\n"

if [ -d '/usr/local/ddos-deflate' ]; then
	printf "Removal script files...\n"
	sleep 0.5
	rm -rf /usr/local/ddos-deflate
fi

if [ -e '/etc/cron.d/ddos-deflate' ]; then
	printf "Removal cronjob...\n"
	sleep 0.5
	rm -f /etc/cron.d/ddos-deflate
fi

printf "Uninstall completed.${NC}\n"
