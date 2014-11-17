% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

pkg(freebsd_conf_common).
depends(freebsd_conf_common, _, [libressl, ca_root_nss, rkhunter]).
:- dynamic freebsd_conf_common_set/0.
met(freebsd_conf_common, _) :- freebsd_conf_common_set.
meet(freebsd_conf_common, freebsd) :-
	sudo_sh(['sysrc ',
	'portmap_enable=NO inetd_enable=NO icmp_drop_redirect=YES icmp_log_redirect=YES ',
	'pf_enable=YES pflog_enable=YES ',
	'clear_tmp_enable=YES syslogd_flags="-ss" ',
	'>/dev/null']),
	sudo_sh(['sysrc -f /etc/periodic.conf ',
	'daily_rkhunter_check_enable=YES daily_rkhunter_update_flags="--update --nocolors" ',
	'daily_rkhunter_update_enable=YES daily_rkhunter_check_flags="--checkall --nocolors --skip-keypress" ',
	'>/dev/null']),
	sudo_sh(['sysrc -f /etc/sysctl.conf ',
	'net.inet.ip.portrange.reservedhigh=0 ',
	'>/dev/null']),
	assertz(freebsd_conf_common_set).
