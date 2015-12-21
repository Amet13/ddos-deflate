#!/bin/bash

RED='\033[0;31m'
GR='\033[0;32m'
NC='\033[0m'

NETSTAT=`which netstat &> /dev/null`
RET=`echo $?`
if [ $RET -ne 0 ]; then
	printf "${RED}Please install netstat from net-tools package at first.${NC}\n"
	exit 1
fi

MAIL=`which mail &> /dev/null`
RET=`echo $?`
if [ $RET -ne 0 ]; then
	printf "${RED}Please install mail from mailx package at first.${NC}\n"
	exit 1
fi

if [ -d '/usr/local/ddos-deflate' ]; then
	printf "${RED}Directory /usr/local/ddos-deflate exists.\n"
	printf "Please uninstall the previous version at first.${NC}\n"
	exit 1
else
	mkdir /usr/local/ddos-deflate
fi

printf "${GR}Installing DDoS-Deflate.${NC}\n"
printf "${GR}Downloading source files...${NC}\n"
printf "${GR}10%%... "
wget -q -O /usr/local/ddos-deflate/ddos-deflate.conf https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos-deflate.conf
printf "30%%... "
wget -q -O /usr/local/ddos-deflate/ignoreip.list https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ignoreip.list
printf "75%%... "
wget -q -O /usr/local/ddos-deflate/ddos-deflate.sh https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos-deflate.sh
chmod 0755 /usr/local/ddos-deflate/ddos-deflate.sh
printf "100%%\n"
printf "Installation has been completed.\n"
printf "SHELL=/bin/bash\n* * * * * root /usr/local/ddos-deflate/ddos-deflate.sh > /dev/null 2>&1\n" > /etc/cron.d/ddos-deflate
printf "Cronjob /etc/cron.d/ddos-deflate has been added.\n"
printf "See DDoS-Deflate at /usr/local/ddos-deflate/.${NC}\n"
