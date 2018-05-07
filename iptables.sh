service iptables restart
iptables -F
iptables -A INPUT -p tcp -m multiport --dports 80,5901 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 80,53,443,9418 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j ACCEPT
iptables -A OUTPUT -j ACCEPT
