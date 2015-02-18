ddos-deflate
============
Shell script blocking DDoS attacks.

It's work for Debian 7.

Installation
------------
```bash
su -
cd /tmp
wget https://raw.githubusercontent.com/Amet13/ddos-deflate/master/install.sh
chmod +x install.sh
./install.sh
```
Add your e-mail:
```bash
vim /usr/local/ddos/ddos.conf
EMAIL_TO="mail@example.com"
```
Add your ignore ip's:
```bash
vim /usr/local/ddos/ignore.ip.list
127.0.0.1
1.1.1.1
2.2.2.2
```
Add cronjob:
```bash
/usr/local/ddos/ddos.sh -c
```
Check:
```bash
/usr/local/ddos/ddos.sh
    101 2.2.2.2
    100 3.3.3.3
      1 servers)
      1 Address
```
```bash
cat /etc/cron.d/ddos.cron
SHELL=/bin/sh
0-59/1 * * * * root /usr/local/ddos/ddos.sh >/dev/null 2>&1
```

Uninstallation
-------------
```bash
su -
cd /tmp
wget https://raw.githubusercontent.com/Amet13/ddos-deflate/master/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
```

Original author
---------------
[zaf@vsnl.com](mailto:zaf@vsnl.com)
