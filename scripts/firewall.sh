#!/bin/bash
#
# Flush all rules
iptables -F
iptables -X
iptables -Z

# Set defaults
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# SSH
iptables -A INPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT

# Syncthing
iptables -A INPUT -m state --state NEW -p tcp --dport 22000 -j ACCEPT

# Make firewall persistant
iptables-save > /etc/iptables/rules.v4
