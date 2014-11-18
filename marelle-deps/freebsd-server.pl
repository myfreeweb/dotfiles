% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

idempotent_pkg(freebsd_conf_server).
depends(freebsd_conf_server, _, [freebsd_conf_common]).
execute(freebsd_conf_server, freebsd) :-
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.server.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/sshd_config > /etc/ssh/sshd_config'),
	sudo_sh('cat ./marelle-tpls/pf.server.conf > /etc/pf.conf'),
	sudo_sh('pfctl -f /etc/pf.conf 2>/dev/null').

pkg(knot).
installs_with_ports(knot, 'dns/knot'). % pkgng version has a hard dep on openssl
idempotent_pkg(knot_enabled).
depends(knot_enabled, _, [knot]).
execute(knot_enabled, freebsd) :-
	sudo_sh('cp -f ./marelle-tpls/knot.conf /usr/local/etc/knot/knot.conf'),
	sudo_sh('cp -f ./marelle-tpls/unrelenting.technology.zone /usr/local/etc/knot/'),
	sysrc('knot_enable').

managed_pkg(privoxy).
idempotent_pkg(privoxy_enabled).
depends(privoxy_enabled, _, [privoxy, freebsd_conf]).
execute(privoxy_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/privoxy.conf > /usr/local/etc/privoxy/config'),
	sysrc('privoxy_enable').

pkg(nginx).
depends(nginx, _, [libressl]).
installs_with_ports(nginx, 'www/nginx', 'WITH="SPDY LUA FILE_AIO SYSLOG_SUPPORT"'). % Also, looks like the pkgng version is statically linked to vulnerable openssl :(
idempotent_pkg(nginx_enabled).
depends(nginx_enabled, _, [nginx]).
execute(nginx_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/nginx.conf > /usr/local/etc/nginx/nginx.conf'),
	sysrc('nginx_enable').

pkg(opensmtpd).
depends(opensmtpd, _, [libressl, ca_root_nss]).
installs_with_ports(opensmtpd, 'mail/opensmtpd').
idempotent_pkg(opensmtpd_enabled).
depends(opensmtpd_enabled, _, [opensmtpd]).
execute(opensmtpd_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/smtpd.conf > /usr/local/etc/mail/smtpd.conf'),
	sudo_sh('cat ./marelle-tpls/aliases > /etc/mail/aliases'),
	sudo_sh('smtpctl update table aliases >/dev/null || true'),
	sysrc('sendmail_enable', 'NO'),
	sysrc('sendmail_submit_enable', 'NO'),
	sysrc('sendmail_outbound_enable', 'NO'),
	sysrc('sendmail_msp_queue_enable', 'NO'),
	sysrc('smtpd_enable').

pkg(amavis).
installs_with_pkgng(amavis, 'security/amavisd-new').
idempotent_pkg(amavis_enabled).
depends(amavis_enabled, _, [amavis]).
execute(amavis_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/amavisd.conf > /usr/local/etc/amavisd.conf'),
	sudo_sh('mkdir -p /var/amavis/tmp /var/amavis/var /var/amavis/db'),
	sudo_sh('chown vscan /var/amavis/tmp /var/amavis/var /var/amavis/db'),
	% sudo_sh('sa-update || true'),
	sysrc('amavisd_enable').

pkg(prosody).
depends(prosody, _, [libressl, ca_root_nss]).
installs_with_ports(prosody, 'net-im/prosody').
idempotent_pkg(prosody_enabled).
depends(prosody_enabled, _, [prosody]).
execute(prosody_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/prosody.cfg.lua > /usr/local/etc/prosody/prosody.cfg.lua'),
	sysrc('prosody_enable').

pkg(znc).
depends(znc, _, [libressl, ca_root_nss]).
installs_with_pkgng(znc).
idempotent_pkg(znc_enabled).
depends(znc_enabled, _, [znc]).
meet(znc_enabled, freebsd) :-
	sudo_sh('pw useradd -n znc -m >/dev/null || true'),
	sudo_sh('mkdir -p /usr/local/etc/znc/configs'),
	sudo_sh('cat ./marelle-tpls/znc.conf | sed -e s/%passwordhash%/`cat /usr/local/etc/znc/passwordhash`/g > /usr/local/etc/znc/configs/znc.conf'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem /usr/local/etc/certs/key.pem > /usr/local/etc/znc/znc.pem'),
	sudo_sh('chown znc:znc /usr/local/etc/znc/configs/znc.conf /usr/local/etc/znc/znc.pem'),
	sysrc('znc_enable').

idempotent_pkg(syncthing_server_enabled).
depends(syncthing_server_enabled, _, [syncthing]).
execute(syncthing_server_enabled, freebsd) :-
	sudo_sh('mkdir -p /var/tmp/syncthing'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem > /var/tmp/syncthing/https-cert.pem'),
	sudo_sh('cat /usr/local/etc/certs/key.pem > /var/tmp/syncthing/https-key.pem'),
	sudo_sh('chown greg:syncthing /var/tmp/syncthing/ /var/tmp/syncthing/*'),
	sysrc('syncthing_enable'),
	sysrc('syncthing_user', 'greg').

managed_pkg(monit).
idempotent_pkg(monit_enabled).
depends(monit_enabled, _, [monit]).
execute(monit_enabled, freebsd) :-
	sysrc('monit_enable'),
	sudo_sh('cat ./marelle-tpls/monitrc | sed -e s/%pushoverkey%/`cat /usr/local/etc/pushoverkey`/g > /usr/local/etc/monitrc'),
	sudo_sh('chmod 0600 /usr/local/etc/monitrc').

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
