% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

pkg(freebsd_conf_server).
depends(freebsd_conf_server, _, [freebsd_conf_common]).
:- dynamic freebsd_conf_server_set/0.
met(freebsd_conf_server, _) :- freebsd_conf_server_set.
meet(freebsd_conf_server, freebsd) :-
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.server.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/pf.server.conf > /etc/pf.conf'),
	sudo_sh('cat ./marelle-tpls/sshd_config > /etc/ssh/sshd_config'),
	assertz(freebsd_conf_server_set).

pkg(knot).
installs_with_ports(knot, 'dns/knot'). % pkgng version has a hard dep on openssl
pkg(knot_enabled).
depends(knot_enabled, _, [knot]).
:- dynamic knot_enabled_set/0.
met(knot_enabled, _) :- knot_enabled_set.
meet(knot_enabled, freebsd) :-
	sudo_sh('cp -f ./marelle-tpls/knot.conf /usr/local/etc/knot/knot.conf'),
	sudo_sh('cp -f ./marelle-tpls/unrelenting.technology.zone /usr/local/etc/knot/'),
	sudo_sh('sysrc knot_enable=YES >/dev/null'),
	assertz(knot_enabled_set).

managed_pkg(privoxy).
pkg(privoxy_enabled).
depends(privoxy_enabled, _, [privoxy, freebsd_conf]).
:- dynamic privoxy_enabled_set/0.
met(privoxy_enabled, _) :- privoxy_enabled_set.
meet(privoxy_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/privoxy.conf > /usr/local/etc/privoxy/config'),
	sudo_sh('sysrc privoxy_enable=YES >/dev/null'),
	assertz(privoxy_enabled_set).

pkg(nginx).
depends(nginx, _, [libressl]).
installs_with_ports(nginx, 'www/nginx', 'WITH="SPDY LUA FILE_AIO SYSLOG_SUPPORT"'). % Also, looks like the pkgng version is statically linked to vulnerable openssl :(
pkg(nginx_enabled).
depends(nginx_enabled, _, [nginx]).
:- dynamic nginx_enabled_set/0.
met(nginx_enabled, _) :- nginx_enabled_set.
meet(nginx_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/nginx.conf > /usr/local/etc/nginx/nginx.conf'),
	sudo_sh('sysrc nginx_enable=YES >/dev/null'),
	assertz(nginx_enabled_set).

pkg(opensmtpd).
depends(opensmtpd, _, [libressl, ca_root_nss]).
installs_with_ports(opensmtpd, 'mail/opensmtpd').
pkg(opensmtpd_enabled).
depends(opensmtpd_enabled, _, [opensmtpd]).
:- dynamic opensmtpd_enabled_set/0.
met(opensmtpd_enabled, _) :- opensmtpd_enabled_set.
meet(opensmtpd_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/smtpd.conf > /usr/local/etc/mail/smtpd.conf'),
	sudo_sh('cat ./marelle-tpls/aliases > /etc/mail/aliases'),
	sudo_sh('smtpctl update table aliases >/dev/null || true'),
	sudo_sh('sysrc sendmail_enable=NO sendmail_submit_enable=NO sendmail_outbound_enable=NO sendmail_msp_queue_enable=NO smtpd_enable=YES >/dev/null'),
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
	% sudo_sh('sa-update || true'),
	sudo_sh('sysrc amavisd_enable=YES >/dev/null'),
	assertz(amavis_enabled_set).

pkg(prosody).
depends(prosody, _, [libressl, ca_root_nss]).
installs_with_ports(prosody, 'net-im/prosody').
pkg(prosody_enabled).
depends(prosody_enabled, _, [prosody]).
:- dynamic prosody_enabled_set/0.
met(prosody_enabled, _) :- prosody_enabled_set.
meet(prosody_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/prosody.cfg.lua > /usr/local/etc/prosody/prosody.cfg.lua'),
	sudo_sh('sysrc prosody_enable=YES >/dev/null'),
	assertz(prosody_enabled_set).

pkg(znc).
depends(znc, _, [libressl, ca_root_nss]).
installs_with_pkgng(znc).
pkg(znc_enabled).
depends(znc_enabled, _, [znc]).
:- dynamic znc_enabled_set/0.
met(znc_enabled, _) :- znc_enabled_set.
meet(znc_enabled, freebsd) :-
	sudo_sh('pw useradd -n znc -m >/dev/null || true'),
	sudo_sh('mkdir -p /usr/local/etc/znc/configs'),
	sudo_sh('cat ./marelle-tpls/znc.conf | sed -e s/%passwordhash%/`cat /usr/local/etc/znc/passwordhash`/g > /usr/local/etc/znc/configs/znc.conf'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem /usr/local/etc/certs/key.pem > /usr/local/etc/znc/znc.pem'),
	sudo_sh('chown znc:znc /usr/local/etc/znc/configs/znc.conf /usr/local/etc/znc/znc.pem'),
	sudo_sh('sysrc znc_enable=YES >/dev/null'),
	assertz(znc_enabled_set).

pkg(syncthing_server_enabled).
depends(syncthing_server_enabled, _, [syncthing]).
:- dynamic syncthing_server_enabled_set/0.
met(syncthing_server_enabled, _) :- syncthing_server_enabled_set.
meet(syncthing_server_enabled, freebsd) :-
	sudo_sh('sysrc syncthing_enable=YES syncthing_user=greg >/dev/null'),
	sudo_sh('mkdir -p /var/tmp/syncthing'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem > /var/tmp/syncthing/https-cert.pem'),
	sudo_sh('cat /usr/local/etc/certs/key.pem > /var/tmp/syncthing/https-key.pem'),
	sudo_sh('chown greg:syncthing /var/tmp/syncthing/ /var/tmp/syncthing/*'),
	assertz(syncthing_server_enabled_set).

managed_pkg(monit).
pkg(monit_enabled).
depends(monit_enabled, _, [monit]).
:- dynamic monit_enabled_set/0.
met(monit_enabled, _) :- monit_enabled_set.
meet(monit_enabled, freebsd) :-
	sudo_sh('sysrc monit_enable=YES >/dev/null'),
	sudo_sh('cat ./marelle-tpls/monitrc | sed -e s/%pushoverkey%/`cat /usr/local/etc/pushoverkey`/g > /usr/local/etc/monitrc'),
	sudo_sh('chmod 0600 /usr/local/etc/monitrc'),
	assertz(monit_enabled_set).

meta_pkg(server, freebsd, [
	freebsd_conf_server, openntpd_enabled, dnscrypt_enabled, unbound_enabled,
	i2p_enabled, tor_enabled, privoxy_enabled,
	knot_enabled, nginx_enabled,
	amavis_enabled, opensmtpd_enabled,
	prosody_enabled,
	znc_enabled,
	syncthing_server_enabled,
	monit_enabled
]).
