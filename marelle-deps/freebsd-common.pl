% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

sysrc(File, Key, Val) :- sudo_sh(['sysrc -f ', File, ' ', Key, '="', Val, '" >/dev/null']).
sysrc(Key, Val) :- sysrc('/etc/rc.conf', Key, Val).
sysrc(Key) :- sysrc(Key, 'YES').
periodic(Key, Val) :- sysrc('/etc/periodic.conf', Key, Val).
periodic(Key) :- periodic(Key, 'YES').
bootloader(Key, Val) :- sysrc('/boot/loader.conf', Key, Val).
bootloader(Key) :- bootloader(Key, 'YES').
auth_conf(Key, Val) :- sysrc('/etc/auth.conf', Key, Val) .
sysctl_w(Key, Val) :- sysrc('/etc/sysctl.conf', Key, Val). % https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=187461 :(
sysctl(Key, Val) :-
	sysctl_w(Key, Val),
	sudo_sh(['sysctl ', Key, '=', Val, ' >/dev/null']).
sysctl(Key) :- sysctl(Key, '1').
lo_alias(N, Ip) :-
	join(['ifconfig_lo0_alias', N], Key),
	join(['inet ', Ip, ' netmask 0xffffffff'], Val),
	sysrc(Key, Val),
	sudo_sh(['ifconfig lo0 alias ', Ip, ' netmask 0xffffffff']).

idempotent_pkg(freebsd_conf_common).
depends(freebsd_conf_common, _, [libressl, ca_root_nss, rkhunter]).
execute(freebsd_conf_common, freebsd) :-
	sysrc('portmap_enable', 'NO'),
	sysrc('inetd_enable', 'NO'),
	sysrc('icmp_drop_redirect'),
	sysrc('icmp_log_redirect'),
	sysrc('pf_enable'),
	sysrc('pflog_enable'),
	sysrc('clear_tmp_enable'),
	sysrc('syslogd_flags', '-ss'), % Do not bind to remote socket
	auth_conf('crypt_default', 'blf'), % bcrypt
	periodic('daily_rkhunter_check_enable'),
	periodic('daily_rkhunter_check_flags', '--checkall --nocolors --skip-keypress'),
	periodic('daily_rkhunter_update_enable'),
	periodic('daily_rkhunter_update_flags', '--update --nocolors'),
	sudo_sh('grep portsnap /etc/crontab >/dev/null || echo "0	7	*	*	*	root	/usr/sbin/portsnap -I cron update" >> /etc/crontab'),
	sudo_sh('grep freebsd-update /etc/crontab >/dev/null || echo "2	8	*	*	*	root	/usr/sbin/freebsd-update cron" >> /etc/crontab'),
	sudo_sh('chflags sappnd /var/log/security'), % append only
	bootloader('accf_http_load'),
	bootloader('accf_dns_load'),
	bootloader('cc_htcp_load'),
	sysctl('vfs.read_max', '32'),
	sysctl('kern.securelevel', '1'),
	sysctl('kern.randompid', '1000'),
	sysctl('kern.ps_arg_cache_limit', '4096'),
	sysctl('security.bsd.stack_guard_page'),
	sysctl('security.bsd.unprivileged_proc_debug', '0'),
	sysctl('security.bsd.see_other_uids', '0'),
	sysctl('security.bsd.see_other_gids', '0'),
	sysctl('net.inet.tcp.drop_synfin'),
	sysctl('net.inet.tcp.ecn.enable'),
	sysctl_w('net.inet.tcp.cc.algorithm', 'htcp'),
	sysctl('net.inet.tcp.keepidle', '60000'),
	sysctl('net.inet.tcp.msl', '6000'),
	sysctl('net.inet.tcp.fast_finwait2_recycle'),
	sysctl('net.inet.ip.sourceroute', '0'),
	sysctl('net.inet.ip.accept_sourceroute', '0'),
	sysctl('net.inet.ip.random_id'),
	sysctl_w('net.inet.ip.portrange.reservedhigh', '0'),
	sysctl('net.inet.ip.fastforwarding'), % I don't use IPSec
	sysctl('net.inet6.ip6.use_tempaddr'),
	sysctl('net.inet6.ip6.prefer_tempaddr'),
	sysctl('net.inet6.icmp6.rediraccept', '0'),
	sysctl('net.inet6.icmp6.nodeinfo', '0').
