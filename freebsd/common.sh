#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# Thanks:
#  https://www.digitalocean.com/community/questions/what-settings-digitalocean-suggested-for-tuning-of-freebsd-installation
#  https://calomel.org/freebsd_network_tuning.html
#  https://gist.github.com/jahil/69265ffbefd86a588649

if [ ! "`id -u`" == 0 ]; then
	echo "Run this as root"
	exit 1
fi

sysctl_set () {
	sysrc -f /etc/sysctl.conf $* >/dev/null
	sysctl $*
}

boot_set () {
	sysrc -f /boot/loader.conf $* >/dev/null
}

boot_set cc_cubic_load="YES"
kldload cc_cubic 2>/dev/null

sysctl_set kern.randompid=1000 \
	kern.ipc.soacceptqueue=1023 \
	security.bsd.stack_guard_page=1 \
	net.inet.ip.random_id=1 \
	net.inet.ip.sourceroute=0 \
	net.inet.ip.accept_sourceroute=0 \
	net.inet.ip.check_interface=1 \
	net.inet.raw.maxdgram=16384 \
	net.inet.raw.recvspace=16384 \
	net.inet.tcp.cc.algorithm="cubic" \
	net.inet.tcp.drop_synfin=1 \
	net.inet.tcp.ecn.enable=0 \
	net.inet.tcp.keepidle=10000 \
	net.inet.tcp.keepintvl=5000 \
	net.inet.tcp.msl=10000 \
	net.inet.tcp.mssdflt=1400 \
	net.inet.tcp.minmss=1300 \
	net.inet.tcp.fast_finwait2_recycle=1 \
	net.inet.tcp.sendbuf_inc=16384 \
	net.inet.tcp.recvbuf_inc=32768 \
	net.inet.tcp.syncache.rexmtlimit=0 \
	net.inet.tcp.delacktime=60 \
	net.inet.tcp.icmp_may_rst=0 \
	net.inet.tcp.blackhole=2 \
	net.inet.tcp.path_mtu_discovery=0 \
	net.inet.tcp.nolocaltimewait=1 \
	net.inet.icmp.icmplim=500 \
	net.inet.icmp.drop_redirect=1 \
	net.inet.udp.blackhole=1 \
	net.inet6.icmp6.rediraccept=0 \
	net.inet6.icmp6.nodeinfo=0 \
	net.local.stream.sendspace=16384 \
	net.local.stream.recvspace=16384 \
	vfs.read_max=128

sysrc portmap_enable="NO" \
	inetd_enable="NO" \
	ntpd_enable="NO" \
	openntpd_enable="YES"

pkg install -y libressl openntpd git wget curl go zsh tmux tree vim-lite srm

chflags sappnd /var/log/security
