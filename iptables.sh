service iptables restart
iptables -F
iptables -A INPUT -p tcp -m multiport --dports 22,25,80,443,5901,9418 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j ACCEPT
iptables -A OUTPUT -j ACCEPT
