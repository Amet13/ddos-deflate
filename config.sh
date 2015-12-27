#!/bin/bash

PROGDIR="/usr/local/ddos-deflate"
IGNORE_IP_LIST="${PROGDIR}/ignoreip.list"
IPT="/sbin/iptables"
LOGFILE="/var/log/ddos-deflate.log"

### How many connections define a bad IP?
NO_OF_CONNECTIONS=300

### An email is sent to the following address when an IP is banned.
### If you want not send email use empty string: EMAIL_TO=""
EMAIL_TO="root"

### Number of seconds the banned IP should remain in blacklist.
BAN_PERIOD=600

### If you want to block only specific ports, set list of ports, for example:
### CUSTOM_PORTS=":80|:443:|:53|:21"
### By default all connections on all ports are blocked.
CUSTOM_PORTS=NO

### If you want enable log, set YES, else set NO.
ENABLE_LOG=YES
