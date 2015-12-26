#!/bin/bash

RED='\033[0;31m'
GR='\033[0;32m'
NC='\033[0m'

ISROOT=`id -u`
if [ $ISROOT -ne 0 ]; then
	printf "${RED}Run install.sh by root.${NC}\n"
	exit 1
fi

if [ -e /usr/bin/netstat ] || [ -e /bin/netstat ]; then
	:
else
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
	printf "Please uninstall the previous version at first.\n"
	printf "For uninstalling run:${NC}\n"
	printf "${GR}wget -q -O - https://raw.githubusercontent.com/Amet13/ddos-deflate/master/uninstall.sh | bash${NC}\n"
	exit 1
else
	mkdir /usr/local/ddos-deflate
fi

DIR="/usr/local/ddos-deflate"
CONFIG="$DIR/config.sh"
IGNOREIP="$DIR/ignoreip.list"
SCRIPT="$DIR/ddos-deflate.sh"

printf "${GR}Installing DDoS-Deflate.\n"
printf "Downloading source files...${NC}\n"
printf "${GR}10%%... "
wget -q -O $CONFIG https://raw.githubusercontent.com/Amet13/ddos-deflate/master/config.sh
printf "30%%... "
wget -q -O $IGNOREIP https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ignoreip.list
printf "75%%... "
wget -q -O $SCRIPT https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos-deflate.sh
chmod 0755 $SCRIPT
printf "100%%\n"
printf "Installation has been completed.${NC}\n"

CRONFILE="/etc/cron.d/ddos-deflate"
printf "SHELL=/bin/bash\n* * * * * root $SCRIPT > /dev/null 2>&1\n" > $CRONFILE
printf "${GR}Cronjob $CRONFILE has been added.\n"
printf "Now setup DDoS-Deflate at $CONFIG${NC}\n"
