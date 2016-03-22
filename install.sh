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

DIR="/usr/local/ddos-deflate"
REPO="https://raw.githubusercontent.com/Amet13/ddos-deflate/master"
if [ -d $DIR ]; then
	printf "${RED}Directory $DIR exists.\n"
	printf "Please uninstall the previous version at first.\n"
	printf "For uninstalling run:${NC}\n"
	printf "${GR}wget -q -O - $REPO/uninstall.sh | bash${NC}\n"
	exit 1
else
	mkdir $DIR
fi

CONFIG="$DIR/ddos-deflate.conf"
IGNOREIP="$DIR/ignoreip.list"
SCRIPT="$DIR/ddos-deflate.sh"
CRONFILE="/etc/cron.d/ddos-deflate"

printf "${GR}Installing DDoS-Deflate.\n"
printf "Downloading source files...${NC}\n"
printf "${GR}10%%... "
wget -q -O $CONFIG $REPO/ddos-deflate.conf
printf "30%%... "
wget -q -O $IGNOREIP $REPO/ignoreip.list
printf "75%%... "
wget -q -O $SCRIPT $REPO/ddos-deflate.sh
printf "100%%\n"
printf "Installation has been completed.${NC}\n"

printf "SHELL=/bin/bash\n* * * * * root bash $SCRIPT > /dev/null; sleep 20; bash $SCRIPT > /dev/null 2>&1\n" > $CRONFILE
printf "${GR}Cronjob $CRONFILE has been added.\n"
printf "Now setup DDoS-Deflate at $CONFIG${NC}\n"
