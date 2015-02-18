ddos-deflate
============
Shell script blocking DDoS attacks.

It's work for Debian 7.
Installation
------------
```bash
# cd /tmp
# wget https://raw.githubusercontent.com/Amet13/ddos-deflate/master/install.sh
# chmod +x install.sh
# ./install.sh
```
Add your e-mail:
```bash
# vim /usr/local/ddos/ddos.conf
EMAIL_TO="mail@example.com"
```
Add your ignore ip's:
```bash
127.0.0.1
1.1.1.1
2.2.2.2
```
Add cronjob:
```bash
# /usr/local/ddos/ddos.sh -c
```
Uninstallation
-------------
```bash
# chmod +x /usr/local/ddos/uninstall.sh
# /usr/local/ddos/uninstall.sh
```

Original author
---------------
[zaf@vsnl.com]

[zaf@vsnl.com]:mailto:zaf@vsnl.com
