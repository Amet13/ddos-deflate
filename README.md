ddos-deflate
============
Shell script blocking DDoS attacks. Fork of [DDoS Deflate](http://deflate.medialayer.com/).

It's work for Debian 7 (please tell me if you've tested script on other distros).

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
crontab -e
* * * * * /usr/local/ddos/ddos.sh >/dev/null 2>&1
```
Check:
```bash
/usr/local/ddos/ddos.sh
    101 2.2.2.2
    100 3.3.3.3
      1 servers)
      1 Address
```

Testing
-------
From another computer:
```bash
user@192.168.0.100 ~ $ ab -n 200000 -c 100 http://server-ip/
```
Check IPTables rules on server:
```bash
iptables -L INPUT
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
DROP       all  --  192.168.0.100        anywhere 
```

Uninstallation
-------------
```bash
su -
cd /tmp
wget https://raw.githubusercontent.com/Amet13/ddos-deflate/master/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
crontab -e
#*/1 * * * * /usr/local/ddos/ddos.sh >/dev/null 2>&1
```

Original author
---------------
[zaf@vsnl.com](mailto:zaf@vsnl.com)
