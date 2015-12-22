#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "${RED}Uninstalling DDoS-Deflate.\n"
printf "Removal script files...\n"
sleep 1

if [ -d '/usr/local/ddos-deflate' ]; then
	rm -rf /usr/local/ddos-deflate
fi

printf "Removal cronjob...\n"
sleep 1

if [ -e '/etc/cron.d/ddos-deflate' ]; then
	rm -f /etc/cron.d/ddos-deflate
fi

printf "Uninstall completed.${NC}\n"
