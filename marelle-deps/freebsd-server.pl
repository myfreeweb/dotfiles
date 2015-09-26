% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

idempotent_pkg(freebsd_conf_common_server).
depends(freebsd_conf_common_server, _, [freebsd_conf_common]).
execute(freebsd_conf_common_server, freebsd) :-
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.server.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/sshd_config > /etc/ssh/sshd_config'),
	sudo_sh('cat /dev/null > /etc/ssh/ssh_host_dsa_key   2>/dev/null || true'),
	sudo_sh('cat /dev/null > /etc/ssh/ssh_host_ecdsa_key 2>/dev/null || true'),
	sudo_sh('chflags schg /etc/ssh/ssh_host_dsa_key'),
	sudo_sh('chflags schg /etc/ssh/ssh_host_ecdsa_key'),
	sudo_sh('cat ./marelle-tpls/pf.server.conf > /etc/pf.conf').
	% sudo_sh('pfctl -F all -f /etc/pf.conf 2>/dev/null').

pkg(supervisord).
installs_with_pkgng(supervisord, 'py27-supervisor').
idempotent_pkg(supervisord_enabled).
depends(supervisord_enabled, _, [supervisord]).
execute(supervisord_enabled, freebsd) :-
	sysrc('supervisord_enable'),
	sudo_sh('mkdir -p /usr/local/etc/supervisord.d'),
	sudo_sh('cat ./marelle-tpls/supervisord.ini > /usr/local/etc/supervisord.conf'),
	sudo_sh('service supervisord start || true').

supervise(Name, Options) :-
	join(Options, OptStr),
	sudo_sh(['cat <<EOF > /usr/local/etc/supervisord.d/', Name, '.ini\n',
					 '[program:', Name, ']\n',
					 'environment=PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"\n',
					 'autostart=true\nautorestart=true\nstartretries=3\n',
					 %'stderr_logfile=syslog\nstdout_logfile=syslog\n',
					 OptStr]),
	sudo_sh(['supervisorctl reread']),
	sudo_sh(['supervisorctl update']),
	sudo_sh(['supervisorctl start ', Name]).

pkg(knot).
installs_with_ports(knot, 'dns/knot1').
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

pip_pkg(waitress).
pip_pkg(klaus).
pip_pkg(markdown).
pip_pkg(watchdog).
idempotent_pkg(klaus_enabled).
depends(klaus_enabled, _, [waitress, klaus, markdown, watchdog, supervisord_enabled]).
execute(klaus_enabled, freebsd) :-
	sudo_sh('mkdir -p /var/run/klaus && chown www:www /var/run/klaus'),
	sudo_sh('cat ./marelle-tpls/klaus.wsgi.py > /usr/local/lib/python2.7/site-packages/klauswsgireload.py'),
	supervise('klaus', [
		'command=/usr/local/bin/python2.7 -m klauswsgireload\n',
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

managed_pkg(znc).
depends(znc, _, [libressl, ca_root_nss, supervisord_enabled]).
idempotent_pkg(znc_enabled).
depends(znc_enabled, _, [znc]).
execute(znc_enabled, freebsd) :-
	sudo_sh('pw useradd -n znc -m >/dev/null || true'),
	sudo_sh('mkdir -p /usr/local/etc/znc/configs'),
	sudo_sh('cat ./marelle-tpls/znc.conf | sed -e s/%passwordhash%/`cat /usr/local/etc/znc/passwordhash`/g > /usr/local/etc/znc/configs/znc.conf'),
	sudo_sh('cat /usr/local/etc/certs/unrelenting.technology.bundle.pem /usr/local/etc/certs/unrelenting.technology.key.pem > /usr/local/etc/znc/znc.pem'),
	sudo_sh('chown znc:znc /usr/local/etc/znc/configs/znc.conf /usr/local/etc/znc/znc.pem'),
	supervise('znc', [
		'command=/usr/local/bin/znc --foreground --datadir=/usr/local/etc/znc\n',
		'user=znc'
	]).

idempotent_pkg(syncthing_server_enabled).
depends(syncthing_server_enabled, _, [syncthing]).
execute(syncthing_server_enabled, freebsd) :-
	sudo_sh('mkdir -p /var/tmp/syncthing'),
	sudo_sh('chown greg:syncthing /var/tmp/syncthing/ /var/tmp/syncthing/*'),
	supervise('syncthing', [
		'command=/usr/local/bin/syncthing -no-browser -home=/var/tmp/syncthing\n',
		'user=greg'
	]).


meta_pkg(server, freebsd, [
	freebsd_conf_common_server, supervisord_enabled,
	openntpd_enabled, unbound_enabled,
	tor_enabled, privoxy_enabled,
	knot_enabled,
	klaus_enabled,
	amavis_enabled, opensmtpd_enabled,
	znc_enabled,
	syncthing_server_enabled
]).
