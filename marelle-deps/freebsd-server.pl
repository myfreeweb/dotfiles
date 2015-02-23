% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

idempotent_pkg(freebsd_conf_common_server).
depends(freebsd_conf_common_server, _, [freebsd_conf_common]).
execute(freebsd_conf_common_server, freebsd) :-
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.server.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/sshd_config > /etc/ssh/sshd_config'),
	sudo_sh('cat ./marelle-tpls/pf.server.conf > /etc/pf.conf').
	% sudo_sh('pfctl -F all -f /etc/pf.conf 2>/dev/null').

pkg(supervisord).
installs_with_pkgng(supervisord, 'py27-supervisor').
idempotent_pkg(supervisord_enabled).
depends(supervisord_enabled, _, [supervisord]).
execute(supervisord_enabled, freebsd) :-
	sysrc('supervisord_enable'),
	sudo_sh('mkdir -p /usr/local/etc/supervisord.d'),
	sudo_sh('cat ./marelle-tpls/supervisord.ini > /usr/local/etc/supervisord.conf').

supervise(Name, Options) :-
	join(Options, OptStr),
	sudo_sh(['cat <<EOF > /usr/local/etc/supervisord.d/', Name, '.ini\n',
					 '[program:', Name, ']\n',
					 'environment=PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"\n',
					 'autostart=true\nautorestart=true\nstartretries=3\n',
					 'stderr_logfile=syslog\nstdout_logfile=syslog\n',
					 OptStr]).

pkg(knot).
installs_with_ports(knot, 'dns/knot'). % pkgng version has a hard dep on openssl
idempotent_pkg(knot_enabled).
depends(knot_enabled, _, [knot]).
execute(knot_enabled, freebsd) :-
	sudo_sh('cp -f ./marelle-tpls/knot.conf /usr/local/etc/knot/knot.conf'),
	sudo_sh('cp -f ./marelle-tpls/*.zone /usr/local/etc/knot/'),
	sysrc('knot_enable').

managed_pkg(privoxy).
idempotent_pkg(privoxy_enabled).
depends(privoxy_enabled, _, [privoxy, freebsd_conf_common]).
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

pip_pkg(waitress).
pip_pkg(klaus).
pip_pkg(markdown).
pip_pkg(watchdog).
idempotent_pkg(klaus_enabled).
depends(klaus_enabled, _, [nginx, waitress, klaus, markdown, watchdog, supervisord_enabled]).
execute(klaus_enabled, freebsd) :-
	sudo_sh('mkdir -p /var/run/klaus && chown www:www /var/run/klaus'),
	sudo_sh('cat ./marelle-tpls/klaus.wsgi.py > /usr/local/lib/python2.7/site-packages/klauswsgireload.py'),
	supervise('klaus', [
		'command=/usr/local/bin/python -m klauswsgireload\n',
		'user=www\n'
	]).

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
installs_with_ports(prosody, 'net-im/prosody', 'WITH="LUAJIT"').
managed_pkg(unbound).
pkg(prosody_plugins).
depends(prosody_plugins, _, [prosody, unbound]).
met(prosody_plugins, freebsd) :-
	isdir('/usr/local/lib/prosody/luaunbound'),
	isdir('/usr/local/lib/prosody/contrib').
meet(prosody_plugins, freebsd) :-
	sudo_sh('hg clone http://code.zash.se/luaunbound/ /usr/local/lib/prosody/luaunbound'),
	sudo_sh('cd /usr/local/lib/prosody/luaunbound && ./squish.sh > /usr/local/etc/prosody/use_unbound.lua'),
	sudo_sh('hg clone http://prosody-modules.googlecode.com/hg/ /usr/local/lib/prosody/contrib').
idempotent_pkg(prosody_enabled).
depends(prosody_enabled, _, [prosody, prosody_plugins, supervisord_enabled]).
execute(prosody_enabled, freebsd) :-
	sudo_sh('cat ./marelle-tpls/prosody.cfg.lua > /usr/local/etc/prosody/prosody.cfg.lua'),
	supervise('prosody', [
		'command=/usr/local/bin/prosody --config=/usr/local/etc/prosody/prosody.cfg.lua\n',
		'user=prosody'
	]).

pkg(znc).
depends(znc, _, [libressl, ca_root_nss, supervisord_enabled]).
installs_with_pkgng(znc).
idempotent_pkg(znc_enabled).
depends(znc_enabled, _, [znc]).
execute(znc_enabled, freebsd) :-
	sudo_sh('pw useradd -n znc -m >/dev/null || true'),
	sudo_sh('mkdir -p /usr/local/etc/znc/configs'),
	sudo_sh('cat ./marelle-tpls/znc.conf | sed -e s/%passwordhash%/`cat /usr/local/etc/znc/passwordhash`/g > /usr/local/etc/znc/configs/znc.conf'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem /usr/local/etc/certs/key.pem > /usr/local/etc/znc/znc.pem'),
	sudo_sh('chown znc:znc /usr/local/etc/znc/configs/znc.conf /usr/local/etc/znc/znc.pem'),
	supervise('znc', [
		'command=/usr/local/bin/znc --foreground --datadir=/usr/local/etc/znc\n',
		'user=znc'
	]).

idempotent_pkg(syncthing_server_enabled).
depends(syncthing_server_enabled, _, [syncthing]).
execute(syncthing_server_enabled, freebsd) :-
	sudo_sh('mkdir -p /var/tmp/syncthing'),
	sudo_sh('cat /usr/local/etc/certs/bundle.pem > /var/tmp/syncthing/https-cert.pem'),
	sudo_sh('cat /usr/local/etc/certs/key.pem > /var/tmp/syncthing/https-key.pem'),
	sudo_sh('chown greg:syncthing /var/tmp/syncthing/ /var/tmp/syncthing/*'),
	supervise('syncthing', [
		'command=/usr/local/bin/syncthing -no-browser -home=/var/tmp/syncthing\n',
		'user=greg'
	]).

meta_pkg(server, freebsd, [
	freebsd_conf_common_server, openssh, supervisord_enabled,
	openntpd_enabled, unbound_enabled,
	i2p_enabled, tor_enabled, privoxy_enabled,
	knot_enabled, nginx_enabled,
	klaus_enabled,
	amavis_enabled, opensmtpd_enabled,
	prosody_enabled,
	znc_enabled,
	syncthing_server_enabled
]).
