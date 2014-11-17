% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice
%
% Server config for FreeBSD 10 -- DO NOT EVEN TRY ON EARLIER VERSIONS

managed_pkg(ca_root_nss).

pkg(libressl).
installs_with_brew(libressl).
installs_with_ports(libressl, 'security/libressl').

managed_pkg(w3m).
depends(w3m, freebsd, [libressl, ca_root_nss]).

managed_pkg(curl).
depends(curl, freebsd, [libressl, ca_root_nss]).

managed_pkg(wget).
depends(wget, freebsd, [libressl, ca_root_nss]).

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
	sudo_sh('ifconfig lo0 alias 127.0.0.53 netmask 0xffffffff'),
	sudo_sh('sysrc local_unbound_enable=YES ifconfig_lo0_alias3="inet 127.0.0.53 netmask 0xffffffff" >/dev/null'),
	sudo_sh('echo "nameserver 127.0.0.53" > /etc/resolv.conf'),
	sudo_sh('echo "supersede domain-name-servers 127.0.0.53;" > /etc/dhclient.conf'),
	assertz(unbound_enabled_set).

managed_pkg(i2p).
managed_pkg(javaservicewrapper).
pkg(i2p_installed).
depends(i2p_installed, _, [i2p]).
depends(i2p_installed, freebsd, [i2p, javaservicewrapper]).
met(i2p_installed, freebsd) :- isfile('/home/_i2p/i2p/i2psvc').
meet(i2p_installed, freebsd) :-
	sudo_sh('pw useradd -n _i2p -m || true'),
	sudo_sh('service i2p install >/dev/null 2>/dev/null'),
	sudo_sh('cp -f /usr/local/bin/javaservicewrapper /home/_i2p/i2p/i2psvc'),
	sudo_sh('cp -f /usr/local/lib/javaservicewrapper/lib/wrapper.jar /home/_i2p/i2p/lib/'),
	sudo_sh('cp -f /usr/local/lib/javaservicewrapper/lib/libwrapper.so /home/_i2p/i2p/lib/'),
	sudo_sh('sed -e s/\\$SYSTEM_java_io_tmpdir/\\\\/var\\\\/tmp/ -e s/\\$INSTALL_PATH/./ -I bak /home/_i2p/i2p/wrapper.config'),
	sudo_sh('chmod 0777 /home/_i2p/i2p/i2psvc /home/_i2p/i2p/lib/wrapper.jar /home/_i2p/i2p/lib/libwrapper.so').
pkg(i2p_enabled).
depends(i2p_enabled, _, [i2p_installed]).
:- dynamic i2p_enabled_set/0.
met(i2p_enabled, _) :- i2p_enabled_set.
meet(i2p_enabled, freebsd) :-
	sudo_sh('sysrc i2p_enable=YES i2p_user=_i2p >/dev/null'),
	assertz(i2p_enabled_set).

managed_pkg(tor). % does not build with libressl :(
pkg(tor_enabled).
depends(tor_enabled, _, [tor, freebsd_conf]).
:- dynamic tor_enabled_set/0.
met(tor_enabled, _) :- tor_enabled_set.
meet(tor_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/torrc | sed -e s/%torpwd%/`cat /usr/local/etc/tor/torpwd`/g > /usr/local/etc/tor/torrc'),
	sudo_sh('sysrc tor_enable=YES ifconfig_lo0_alias3="inet 127.0.0.5 netmask 0xffffffff" >/dev/null'),
	sudo_sh('ifconfig lo0 alias 127.0.0.5 netmask 0xffffffff'),
	assertz(tor_enabled_set).

pkg(pulse).
installs_with_pkgng(pulse, 'net/syncthing').
installs_with_brew(pulse, 'syncthing').
