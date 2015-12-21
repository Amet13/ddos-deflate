ddos-deflate
============
Shell script blocking DDoS attacks. Fork of [(D)DoS Deflate](http://deflate.medialayer.com/).

Installation
------------
```bash
sudo -i
cd /tmp
wget -q -O - https://raw.githubusercontent.com/Amet13/ddos-deflate/devel/install.sh | bash
```
Setup config:
```bash
vim /usr/local/ddos-deflate/ddos-deflate.conf
NO_OF_CONNECTIONS=500
EMAIL_TO="mail@example.com"
BAN_PERIOD=1000
```
Add your ignore ip's to ignorelist:
```bash
vim /usr/local/ddos-deflate/ignoreip.list
127.0.0.1
192.168.0.1
1.1.1.1
2.2.2.2
```

Check:
```bash
/usr/local/ddos-deflate/ddos-deflate.sh
    724 127.0.0.1
    214 2.2.2.2
     59 3.3.3.3
...
```

Testing
-------
Run ab from another computer:
```bash
user@192.168.0.100 ~ $ ab -n 200000 -c 100 http://server-ip/
```
Check new IPTables rules on server:
```bash
iptables -L INPUT
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
DROP       all  --  192.168.0.100        anywhere
```

Alternative usage
-----------------
By default script block only HTTP attackers (port 80).

If you want block all ports (FTP, SSH, DNS, other), you can replace:
```bash
netstat -ntu | grep ":80" | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr > $BAD_IP_LIST
```
to
```bash
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr > $BAD_IP_LIST
```
in `/usr/local/ddos-deflate/ddos-deflate.sh`

Updating
--------
```bash
cd /usr/local/ddos-deflate/
wget https://raw.githubusercontent.com/Amet13/ddos-deflate/devel/ddos-deflate.sh -O ddos-deflate.sh
```

Uninstallation
--------------
```bash
sudo -i
cd /tmp
wget -q -O - https://raw.githubusercontent.com/Amet13/ddos-deflate/devel/uninstall.sh | bash
```

Original author
---------------
[zaf@vsnl.com](mailto:zaf@vsnl.com)

License
-------
[Artistic License 2.0](http://directory.fsf.org/wiki/License:ArtisticLicense2.0)
