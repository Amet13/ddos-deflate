#!/bin/bash

###################################################
# DDoS-Deflate by Amet13 <admin@amet13.name>      #
# It's fork of DDoS-Deflate by Zaf <zaf@vsnl.com> #
# Repo: https://github.com/Amet13/ddos-deflate    #
###################################################

RED='\033[0;31m'
NC='\033[0m'
DATE=`date "+%d/%m/%Y [%H:%M:%S]"`

CONF="/usr/local/ddos-deflate/ddos-deflate.conf"
if [ -f "$CONF" ]; then
	source $CONF
else
	printf "${RED}$CONF not found. Exiting.${NC}\n"
	exit 1
fi

unbanip()
{
	UNBAN_SCRIPT=`mktemp /tmp/unban.XXXXXXXX`
	TMP_FILE=`mktemp /tmp/unban.XXXXXXXX`
	UNBAN_IP_LIST=`mktemp /tmp/unban.XXXXXXXX`
	echo '#!/bin/bash' > $UNBAN_SCRIPT
	echo "sleep $BAN_PERIOD" >> $UNBAN_SCRIPT
	while read LINE; do
		echo "$IPT -t raw -D PREROUTING -s $LINE -j DROP" >> $UNBAN_SCRIPT
		echo $LINE >> $UNBAN_IP_LIST
	done < $BANNED_IP_LIST
	echo "grep -v --file=$UNBAN_IP_LIST $IGNORE_IP_LIST > $TMP_FILE" >> $UNBAN_SCRIPT
	echo "mv $TMP_FILE $IGNORE_IP_LIST" >> $UNBAN_SCRIPT
	echo "rm -f $UNBAN_SCRIPT" >> $UNBAN_SCRIPT
	echo "rm -f $UNBAN_IP_LIST" >> $UNBAN_SCRIPT
	echo "rm -f $TMP_FILE" >> $UNBAN_SCRIPT
	. $UNBAN_SCRIPT &
}

TMP_PREFIX='/tmp/ddos-deflate'
TMP_FILE="mktemp $TMP_PREFIX.XXXXXXXX"
BANNED_IP_MAIL=`$TMP_FILE`
BANNED_IP_LIST=`$TMP_FILE`

echo "Banned the following IP addresses on $DATE" > $BANNED_IP_MAIL
echo "From: `hostname -f` (`hostname -i`)" >> $BANNED_IP_MAIL
echo >> $BANNED_IP_MAIL

BAD_IP_LIST=`$TMP_FILE`
if [ $CUSTOM_PORTS == "NO" ]; then
	netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr > $BAD_IP_LIST
else
	netstat -ntu | grep -E "$CUSTOM_PORTS" | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr > $BAD_IP_LIST
fi

cat $BAD_IP_LIST

IP_BAN_NOW=0
while read line; do
	CURR_LINE_CONN=$(echo $line | cut -d" " -f1)
	CURR_LINE_IP=$(echo $line | cut -d" " -f2)
	if [ $CURR_LINE_CONN -lt $NO_OF_CONNECTIONS ]; then
		break
	fi
	IGNORE_BAN=`grep -cx $CURR_LINE_IP $IGNORE_IP_LIST`
	if [ $IGNORE_BAN -ge 1 ]; then
		continue
	fi
	IP_BAN_NOW=1
	echo "$CURR_LINE_IP with $CURR_LINE_CONN connections blocked on $BAN_PERIOD seconds" >> $BANNED_IP_MAIL
	echo $CURR_LINE_IP >> $BANNED_IP_LIST
	echo $CURR_LINE_IP >> $IGNORE_IP_LIST
	$IPT -t raw -I PREROUTING -s $CURR_LINE_IP -j DROP
	if [ $ENABLE_LOG == "YES" ]; then
		echo "$DATE -- $CURR_LINE_IP blocked on $BAN_PERIOD seconds" >> $LOGFILE
	fi
done < $BAD_IP_LIST

if [ $IP_BAN_NOW -eq 1 ]; then
	if [ $EMAIL_TO != "" ]; then
		cat $BANNED_IP_MAIL | mail -s "IP addresses banned on $DATE" $EMAIL_TO
	fi
	unbanip
fi

rm -f $TMP_PREFIX.*
