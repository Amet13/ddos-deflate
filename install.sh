#!/bin/sh

# colors
RED='\033[0;31m'
GR='\033[0;32m'
NC='\033[0m'

if [ -d '/usr/local/ddos-deflate' ]; then
	printf "${RED}Directory /usr/local/ddos-deflate exists. Please uninstall the previous version first.${NC}\n"
	exit 0
else
	mkdir /usr/local/ddos-deflate
fi

clear
printf "${GR}Installing DDoS-Deflate...${NC}\n"
printf "${GR}Downloading source files...${NC}\n"
printf "${GR}10%%... "
wget -q -O /usr/local/ddos-deflate/ddos.conf https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos.conf
printf "30%%... "
wget -q -O /usr/local/ddos-deflate/ignore.ip.list https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ignore.ip.list
printf "75%%... "
wget -q -O /usr/local/ddos-deflate/ddos.sh https://raw.githubusercontent.com/Amet13/ddos-deflate/master/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
printf "100%%\n"
printf "Installation has been completed.\n"
printf "See DDoS-Deflate at /usr/local/ddos-deflate/${NC}\n"
