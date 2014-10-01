% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice
%
% Server config for FreeBSD 10 -- DO NOT EVEN TRY ON EARLIER VERSIONS

pkg(freebsd_conf).
depends(freebsd_conf, _, [libressl]).
:- dynamic freebsd_conf_set/0.
met(freebsd_conf, _) :- freebsd_conf_set.
meet(freebsd_conf, freebsd) :-
	sudo_or_empty(Sudo),
	bash([Sudo, 'sysrc portmap_enable=NO inetd_enable=NO clear_tmp_enable=YES syslogd_flags="-ss" icmp_drop_redirect=YES icmp_log_redirect=YES >/dev/null']),
	bash([Sudo, 'cp -f ./marelle-tpls/make.conf /etc']),
	assertz(freebsd_conf_set).

managed_pkg(openntpd).
pkg(openntpd_enabled).
depends(openntpd_enabled, _, [openntpd]).
:- dynamic openntpd_enabled_set/0.
met(openntpd_enabled, _) :- openntpd_enabled_set.
meet(openntpd_enabled, freebsd) :-
	sudo_or_empty(Sudo),
	bash([Sudo, 'sysrc ntpd_enable=NO openntpd_enable=YES >/dev/null']),
	assertz(openntpd_enabled_set).

managed_pkg('dnscrypt-proxy').
pkg(dnscrypt_enabled).
depends(dnscrypt_enabled, _, ['dnscrypt-proxy']).
:- dynamic dnscrypt_enabled_set/0.
met(dnscrypt_enabled, _) :- dnscrypt_enabled_set.
meet(dnscrypt_enabled, freebsd) :-
	sudo_or_empty(Sudo),
	bash(['cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/cloudns-can/g    -e s/%name%/cloudns_can/g    -e s/%ip%/127.0.0.2/g | ', Sudo, 'tee /usr/local/etc/rc.d/dnscrypt-proxy-cloudns-can    >/dev/null']),
	bash(['cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/cloudns-syd/g    -e s/%name%/cloudns_syd/g    -e s/%ip%/127.0.0.3/g | ', Sudo, 'tee /usr/local/etc/rc.d/dnscrypt-proxy-cloudns-syd    >/dev/null']),
	bash(['cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/opennic-ca-ns3/g -e s/%name%/opennic_ca_ns3/g -e s/%ip%/127.0.0.4/g | ', Sudo, 'tee /usr/local/etc/rc.d/dnscrypt-proxy-opennic-ca-ns3 >/dev/null']),
	bash([Sudo, 'chmod +x /usr/local/etc/rc.d/dnscrypt-proxy*']),
	bash([Sudo, 'ifconfig lo0 alias 127.0.0.2 netmask 0xffffffff']),
	bash([Sudo, 'ifconfig lo0 alias 127.0.0.3 netmask 0xffffffff']),
	bash([Sudo, 'ifconfig lo0 alias 127.0.0.4 netmask 0xffffffff']),
	bash([Sudo, 'sysrc ',
		'ifconfig_lo0_alias0="inet 127.0.0.2 netmask 0xffffffff" ',
		'ifconfig_lo0_alias1="inet 127.0.0.3 netmask 0xffffffff" ',
		'ifconfig_lo0_alias2="inet 127.0.0.4 netmask 0xffffffff" ',
		'dnscrypt_proxy_cloudns_can_enable=YES ',
		'dnscrypt_proxy_cloudns_syd_enable=YES ',
		'dnscrypt_proxy_opennic_ca_ns3_enable=YES ',
		'>/dev/null']),
	assertz(dnscrypt_enabled_set).

pkg(unbound_enabled).
depends(unbound_enabled, _, [dnscrypt_enabled]).
:- dynamic unbound_enabled_set/0.
met(unbound_enabled, _) :- unbound_enabled_set.
meet(unbound_enabled, freebsd) :-
	sudo_or_empty(Sudo),
	bash([Sudo, 'cp -f ./marelle-tpls/unbound.conf /var/unbound']),
	bash([Sudo, 'sysrc local_unbound_enable=YES >/dev/null']),
	assertz(unbound_enabled_set).

meta_pkg(server, [
        freebsd_conf, openntpd_enabled, dnscrypt_enabled, unbound_enabled
]).
