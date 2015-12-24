#!/bin/bash

PROGDIR="/usr/local/ddos-deflate"
IGNORE_IP_LIST="${PROGDIR}/ignoreip.list"
IPT="/sbin/iptables"

### How many connections define a bad IP?
NO_OF_CONNECTIONS=300

### An email is sent to the following address when an IP is banned.
EMAIL_TO="root"

### Number of seconds the banned IP should remain in blacklist.
BAN_PERIOD=600

### If you want block only HTTP connections set YES, for blocking all connections set NO.
ONLY_HTTP=YES
