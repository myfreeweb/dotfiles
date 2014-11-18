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
sysctl(Key, Val) :-
	sysrc('/etc/sysctl.conf', Key, Val), % https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=187461 :(
	sudo_sh(['sysctl ', Key, '=', Val, ' >/dev/null']).
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
	sysrc('syslogd_flags', '-ss'),
	periodic('daily_rkhunter_check_enable'),
	periodic('daily_rkhunter_check_flags', '--checkall --nocolors --skip-keypress'),
	periodic('daily_rkhunter_update_enable'),
	periodic('daily_rkhunter_update_flags', '--update --nocolors'),
	sysctl('net.inet.ip.portrange.reservedhigh', '0').
