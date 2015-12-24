#!/bin/bash

RED='\033[0;31m'
GR='\033[0;32m'
NC='\033[0m'

ISROOT=`id -u`
if [ $ISROOT -ne 0 ]; then
	printf "${RED}Run install.sh by root.${NC}\n"
	exit 1
fi

if [ ! -e /usr/bin/netstat ] || [ ! -e /bin/netstat ]; then
	printf "${RED}Please install netstat from net-tools package at first.${NC}\n"
	printf "For example:\n${GR}yum install net-tools${NC} or ${GR}apt-get install net-tools${NC}\n"
	exit 1
fi

if [ ! -e /usr/bin/mail ]; then
	printf "${RED}Please install mail from mailx or mailutils package at first.${NC}\n"
	printf "For example:\n${GR}yum install mailx${NC} or ${GR}apt-get install mailutils${NC}\n"
	exit 1
fi

if [ -d '/usr/local/ddos-deflate' ]; then
	printf "${RED}Directory /usr/local/ddos-deflate exists.\n"
	printf "Please uninstall the previous version at first.${NC}\n"
	exit 1
else
	mkdir /usr/local/ddos-deflate
fi

printf "${GR}Installing DDoS-Deflate.\n"
printf "Downloading source files...${NC}\n"
printf "${GR}10%%... "
wget -q -O /usr/local/ddos-deflate/ddos-deflate.conf https://raw.githubusercontent.com/Amet13/ddos-deflate/master/config.sh
printf "30%%... "
wget -q -O /usr/local/ddos-deflate/ignoreip.list https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ignoreip.list
printf "75%%... "
wget -q -O /usr/local/ddos-deflate/ddos-deflate.sh https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos-deflate.sh
chmod 0755 /usr/local/ddos-deflate/ddos-deflate.sh
printf "100%%\n"
printf "Installation has been completed.${NC}\n"
printf "SHELL=/bin/bash\n* * * * * root /usr/local/ddos-deflate/ddos-deflate.sh > /dev/null 2>&1\n" > /etc/cron.d/ddos-deflate
printf "${GR}Cronjob /etc/cron.d/ddos-deflate has been added.\n"
printf "Now setup DDoS-Deflate at /usr/local/ddos-deflate/config.sh${NC}\n"
