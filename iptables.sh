service iptables restart
iptables -F
iptables -A INPUT -p tcp -m multiport --dports 80,443,5901 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP
iptables -A OUTPUT -j ACCEPT
