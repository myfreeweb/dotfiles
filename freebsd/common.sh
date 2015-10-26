#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

if [ ! "`id -u`" == 0 ]; then
	echo "Run this as root"
	exit 1
fi

sysctl_set () {
	sysrc -f /etc/sysctl.conf $* >/dev/null
	sysctl $*
}

sysctl_set kern.randompid=1000 \
	security.bsd.stack_guard_page=1 \
	net.inet.tcp.drop_synfin=1 \
	net.inet.tcp.ecn.enable=1 \
	net.inet6.icmp6.rediraccept=0 \
	net.inet6.icmp6.nodeinfo=0 \
	net.inet.ip.portrange.reservedhigh=0 \
	net.inet.ip.random_id=1 \
	net.inet.ip.sourceroute=0 \
	net.inet.ip.accept_sourceroute=0 \
	net.inet.tcp.keepidle=60000 \
	net.inet.tcp.msl=6000 \
	net.inet.tcp.fast_finwait2_recycle=1

sysrc portmap_enable="NO" \
	inetd_enable="NO" \
	ntpd_enable="NO" \
	openntpd_enable="YES"

pkg install -y libressl openntpd git go zsh tmux tree vim-lite

chflags sappnd /var/log/security
