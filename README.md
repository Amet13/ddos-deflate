ddos-deflate
============
Shell script blocking DDoS attacks. Simplified fork of [(D)DoS Deflate](http://deflate.medialayer.com/).

Installation
------------
```bash
sudo -i
cd /tmp
wget -q -O - https://raw.githubusercontent.com/Amet13/ddos-deflate/master/install.sh | bash
```
Setup config for example:
```bash
vim /usr/local/ddos-deflate/config.sh
NO_OF_CONNECTIONS=500
EMAIL_TO="mail@example.com"
BAN_PERIOD=60
CUSTOM_PORTS=":80|:443:|:53|:21"
ENABLE_LOG=YES
```

Add your ignore IP's to ignore list:
```bash
vim /usr/local/ddos-deflate/ignoreip.list
127.0.0.1
192.168.0.1
1.1.1.1
2.2.2.2
```

Check:
```bash
bash /usr/local/ddos-deflate/ddos-deflate.sh
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

Check logs:
```bash
tail -1 /var/log/ddos-deflate.log
26/12/2015 [17:50:00] -- 192.168.0.100 blocked on 60 seconds
```

Check your inbox:
```
Subject: IP addresses banned on 26/12/2015 [17:50:02]

Banned the following IP addresses on 26/12/2015 [17:50:02]
From: hostname.tld (192.168.0.13)

192.168.0.100 with 4183 connections blocked on 60 seconds
```

Uninstallation
--------------
```bash
sudo -i
cd /tmp
wget -q -O - https://raw.githubusercontent.com/Amet13/ddos-deflate/master/uninstall.sh | bash
```

Original author
---------------
[zaf@vsnl.com](mailto:zaf@vsnl.com)

License
-------
[Artistic License 2.0](http://directory.fsf.org/wiki/License:ArtisticLicense2.0)
