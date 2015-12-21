#!/bin/bash

###################################################
# DDoS-Deflate by Amet13 <admin@amet13.name>      #
# It's fork of DDoS-Deflate by Zaf <zaf@vsnl.com> #
# https://github.com/Amet13/ddos-deflate          #
###################################################

RED='\033[0;31m'
GR='\033[0;32m'
NC='\033[0m'

#apf/kill убрал

load_conf()
{
	CONF="/usr/local/ddos-deflate/ddos-deflate.conf"
	if [ -f "$CONF" ]; then
		source $CONF
	else
		printf "${RED}${CONF} not found.${NC}\n"
		exit 1
	fi
}

is_netstat()
{
	NETSTAT=`which netstat`
	RET=`echo $?`
	if [ $RET -ne 0 ]; then
		printf "${RED}Please install netstat from net-tools package.${NC}\n"
	else
		printf "${GR}Netstat already installed in your system.${NC}\n"
}

load_conf
is_netstat

TMP_PREFIX='/tmp/ddos'
TMP_FILE="mktemp $TMP_PREFIX.XXXXXXXX"
BANNED_IP_MAIL=`$TMP_FILE`
BANNED_IP_LIST=`$TMP_FILE`
echo "Banned the following ip addresses on `date`" > $BANNED_IP_MAIL
echo "From `hostname -f` (`hostname --ip-address`)" >> $BANNED_IP_MAIL
echo >> $BANNED_IP_MAIL
BAD_IP_LIST=`$TMP_FILE`
netstat -ntu | grep ":80" | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr > $BAD_IP_LIST
cat $BAD_IP_LIST
if [ $KILL -eq 1 ]; then
	IP_BAN_NOW=0
	while read line; do
		CURR_LINE_CONN=$(echo $line | cut -d" " -f1)
		CURR_LINE_IP=$(echo $line | cut -d" " -f2)
		if [ $CURR_LINE_CONN -lt $NO_OF_CONNECTIONS ]; then
			break
		fi
		IGNORE_BAN=`grep -c $CURR_LINE_IP $IGNORE_IP_LIST`
		if [ $IGNORE_BAN -ge 1 ]; then
			continue
		fi
		IP_BAN_NOW=1
		echo "$CURR_LINE_IP with $CURR_LINE_CONN connections" >> $BANNED_IP_MAIL
		echo $CURR_LINE_IP >> $BANNED_IP_LIST
		echo $CURR_LINE_IP >> $IGNORE_IP_LIST
		if [ $APF_BAN -eq 1 ]; then
			$APF -d $CURR_LINE_IP
		else
			$IPT -I INPUT -s $CURR_LINE_IP -j DROP
		fi
	done < $BAD_IP_LIST
	if [ $IP_BAN_NOW -eq 1 ]; then
		dt=`date`
		if [ $EMAIL_TO != "" ]; then
			cat $BANNED_IP_MAIL | mail -s "IP addresses banned on $dt" $EMAIL_TO
		fi
		unbanip
	fi
fi
rm -f $TMP_PREFIX.*
