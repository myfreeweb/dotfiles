#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

sysctl_set () {
	sysrc -f /etc/sysctl.conf "$*" >/dev/null
	sysctl "$*"
}

sysctl_set kern.randompid=1000
sysctl_set security.bsd.stack_guard_page=1
sysctl_set net.inet.tcp.drop_synfin=1
sysctl_set net.inet.tcp.ecn.enable=1
sysctl_set net.inet6.icmp6.rediraccept=0
sysctl_set net.inet6.icmp6.nodeinfo=0
sysctl_set net.inet.ip.portrange.reservedhigh=0
sysctl_set net.inet.ip.random_id=1
sysctl_set net.inet.ip.sourceroute=0
sysctl_set net.inet.ip.accept_sourceroute=0
sysctl_set net.inet.tcp.keepidle=60000
sysctl_set net.inet.tcp.msl=6000
sysctl_set net.inet.tcp.fast_finwait2_recycle=1

sysrc portmap_enable="NO"
sysrc inetd_enable="NO"
sysrc ntpd_enable="NO"
sysrc openntpd_enable="YES"

pkg install openntpd git go vim-lite

chflags sappnd /var/log/security
