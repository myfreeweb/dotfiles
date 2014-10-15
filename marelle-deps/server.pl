% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice
%
% Server config for FreeBSD 10 -- DO NOT EVEN TRY ON EARLIER VERSIONS

managed_pkg(ca_root_nss).

pkg(freebsd_conf).
depends(freebsd_conf, _, [libressl, ca_root_nss]).
:- dynamic freebsd_conf_set/0.
met(freebsd_conf, _) :- freebsd_conf_set.
meet(freebsd_conf, freebsd) :-
	sudo_sh(['sysrc ',
	'sendmail_enable=NO sendmail_submit_enable=NO sendmail_outbound_enable=NO sendmail_msp_queue_enable=NO ',
	'portmap_enable=NO inetd_enable=NO icmp_drop_redirect=YES icmp_log_redirect=YES ',
	'clear_tmp_enable=YES syslogd_flags="-ss" ',
	'>/dev/null']),
	sudo_sh('cp -f ./marelle-tpls/make.conf /etc'),
	assertz(freebsd_conf_set).

managed_pkg(openntpd).
pkg(openntpd_enabled).
depends(openntpd_enabled, _, [openntpd]).
:- dynamic openntpd_enabled_set/0.
met(openntpd_enabled, _) :- openntpd_enabled_set.
meet(openntpd_enabled, freebsd) :-
	sudo_sh('sysrc ntpd_enable=NO openntpd_enable=YES >/dev/null'),
	assertz(openntpd_enabled_set).

managed_pkg('dnscrypt-proxy').
pkg(dnscrypt_enabled).
depends(dnscrypt_enabled, _, ['dnscrypt-proxy']).
:- dynamic dnscrypt_enabled_set/0.
met(dnscrypt_enabled, _) :- dnscrypt_enabled_set.
meet(dnscrypt_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/cloudns-can/g    -e s/%name%/cloudns_can/g    -e s/%ip%/127.0.0.2/g > /usr/local/etc/rc.d/dnscrypt-proxy-cloudns-can'),
	sudo_sh('cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/cloudns-syd/g    -e s/%name%/cloudns_syd/g    -e s/%ip%/127.0.0.3/g > /usr/local/etc/rc.d/dnscrypt-proxy-cloudns-syd'),
	sudo_sh('cat ./marelle-tpls/dnscrypt-proxy.sh | sed -e s/%resolver%/opennic-ca-ns3/g -e s/%name%/opennic_ca_ns3/g -e s/%ip%/127.0.0.4/g > /usr/local/etc/rc.d/dnscrypt-proxy-opennic-ca-ns3'),
	sudo_sh('chmod +x /usr/local/etc/rc.d/dnscrypt-proxy*'),
	sudo_sh('ifconfig lo0 alias 127.0.0.2 netmask 0xffffffff'),
	sudo_sh('ifconfig lo0 alias 127.0.0.3 netmask 0xffffffff'),
	sudo_sh('ifconfig lo0 alias 127.0.0.4 netmask 0xffffffff'),
	sudo_sh(['sysrc ',
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
	sudo_sh('cp -f ./marelle-tpls/unbound.conf /var/unbound'),
	sudo_sh('sysrc local_unbound_enable=YES >/dev/null'),
	assertz(unbound_enabled_set).

managed_pkg(i2p).
managed_pkg(javaservicewrapper).
pkg(i2p_enabled).
depends(i2p_enabled, _, [i2p, javaservicewrapper]).
met(i2p_enabled, _) :- isfile('/home/_i2p/i2p/i2psvc').
meet(i2p_enabled, freebsd) :-
	sudo_sh('pw useradd -n _i2p -m || true'),
	sudo_sh('sysrc i2p_enable=YES i2p_user=_i2p'),
	sudo_sh('service i2p install >/dev/null 2>/dev/null'),
	sudo_sh('cp -f /usr/local/bin/javaservicewrapper /home/_i2p/i2p/i2psvc'),
	sudo_sh('cp -f /usr/local/lib/javaservicewrapper/lib/wrapper.jar /home/_i2p/i2p/lib/'),
	sudo_sh('cp -f /usr/local/lib/javaservicewrapper/lib/libwrapper.so /home/_i2p/i2p/lib/'),
	sudo_sh('sed -e s/\\$SYSTEM_java_io_tmpdir/\\\\/var\\\\/tmp/ -e s/\\$INSTALL_PATH/./ -I bak /home/_i2p/i2p/wrapper.config'),
	sudo_sh('chmod 0777 /home/_i2p/i2p/i2psvc /home/_i2p/i2p/lib/wrapper.jar /home/_i2p/i2p/lib/libwrapper.so').

pkg(nginx).
depends(nginx, _, [libressl]).
installs_with_ports(nginx, 'www/nginx', 'WITH="SPDY"'). % Also, looks like the pkgng version is statically linked to vulnerable openssl :(

pkg(opensmtpd).
depends(opensmtpd, _, [libressl, ca-root-nss]).
installs_with_ports(opensmtpd, 'mail/opensmtpd').
pkg(opensmtpd_enabled).
depends(opensmtpd_enabled, _, [opensmtpd]).
:- dynamic opensmtpd_enabled_set/0.
met(opensmtpd_enabled, _) :- opensmtpd_enabled_set.
meet(opensmtpd_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/smtpd.conf > /usr/local/etc/mail/smtpd.conf'),
	sudo_sh('cat ./marelle-tpls/aliases > /etc/mail/aliases'),
	sudo_sh('smtpctl update table aliases >/dev/null || true'),
	sudo_sh('sysrc smtpd_enable=YES >/dev/null'),
	assertz(opensmtpd_enabled_set).

pkg(amavis).
installs_with_pkgng(amavis, 'security/amavisd-new').
pkg(amavis_enabled).
depends(amavis_enabled, _, [amavis]).
:- dynamic amavis_enabled_set/0.
met(amavis_enabled, _) :- amavis_enabled_set.
meet(amavis_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/amavisd.conf > /usr/local/etc/amavisd.conf'),
	sudo_sh('mkdir -p /var/amavis/tmp /var/amavis/var /var/amavis/db'),
	sudo_sh('chown vscan /var/amavis/tmp /var/amavis/var /var/amavis/db'),
	sudo_sh('sa-update || true'),
	sudo_sh('sysrc amavisd_enable=YES >/dev/null'),
	assertz(amavis_enabled_set).

pkg(prosody).
depends(prosody, _, [libressl, ca-root-nss]).
installs_with_ports(prosody, 'net-im/prosody').
pkg(prosody_enabled).
depends(prosody_enabled, _, [prosody]).
:- dynamic prosody_enabled_set/0.
met(prosody_enabled, _) :- prosody_enabled_set.
meet(prosody_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/prosody.cfg.lua > /usr/local/etc/prosody/prosody.cfg.lua'),
	sudo_sh('sysrc prosody_enable=YES >/dev/null'),
	assertz(prosody_enabled_set).

meta_pkg(server, [
	freebsd_conf, openntpd_enabled, dnscrypt_enabled, unbound_enabled,
	% i2p_enabled, % too much ram usage :(
	nginx,
	amavis_enabled, opensmtpd_enabled,
	prosody_enabled
]).
