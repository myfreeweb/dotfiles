% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice
%
% Thanks:
%  https://cooltrainer.org/a-freebsd-desktop-howto/

idempotent_pkg(freebsd_conf_desktop).
depends(freebsd_conf_desktop, _, [freebsd_conf_common]).
execute(freebsd_conf_desktop, freebsd) :-
	sysrc('background_dhclient'),
	sysctl('kern.ipc.shm_allow_removed', '1'),
	sysctl('kern.ipc.shmmax', '67108864'),
	sysctl('kern.ipc.shmall', '32768'),
	sysctl('kern.sched.preempt_thresh', '224'),
	sysctl('kern.maxfiles', '200000'),
	sysctl('hw.syscons.bell', '0'),
	sysctl('vfs.usermount', '1'),
	bootloader('tmpfs_load'),
	bootloader('aio_load'),
	bootloader('libiconv_load'),
	bootloader('libmchain_load'),
	bootloader('cd9660_iconv_load'),
	bootloader('msdosfs_iconv_load'),
	bootloader('fuse_load'),
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.desktop.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/pf.desktop.conf > /etc/pf.conf'),
	sudo_sh('cat ./marelle-tpls/pf.desktop.conf > /etc/pf.conf').
%	sudo_sh('pfctl -f /etc/pf.conf 2>/dev/null').

pkg(freetype2).
installs_with_ports(freetype2, 'print/freetype2', 'WITH="LCD_FILTERING"').

managed_pkg(xorg).
depends(xorg, freebsd, [freetype2]).

pkg(vbox_client).
depends(vbox_client, freebsd, [xorg]).
installs_with_pkgng(vbox_client, 'emulators/virtualbox-ose-additions').

idempotent_pkg(vbox_client_enabled).
depends(vbox_client_enabled, freebsd, [vbox_client]).
execute(vbox_client_enabled, freebsd) :-
	sysrc('vboxguest_enable'),
	sysrc('vboxservice_enable').

managed_pkg(compton).
managed_pkg(unclutter).
managed_pkg(bspwm).
pkg(dmenu).
installs_with_ports(dmenu, 'x11/dmenu', 'WITH="XFT"').
managed_pkg(sterm).

managed_pkg(zathura).
managed_pkg('zathura-ps').
managed_pkg('zathura-djvu').
managed_pkg('zathura-pdf-mupdf').
depends(zathura, freebsd, ['zathura-ps', 'zathura-djvu', 'zathura-pdf-mupdf']).

managed_pkg(feh).
managed_pkg(dunst).
managed_pkg(xclip).
managed_pkg(xsel).
managed_pkg(scrot).
managed_pkg('gnome-themes-standard').
pkg(webfonts).
installs_with_ports(webfonts, 'x11-fonts/webfonts', 'WITH="MSWINDOWS_LICENSE"').
managed_pkg(fira).
managed_pkg(noto).
managed_pkg(paratype).
managed_pkg('sourcecodepro-ttf').
managed_pkg('sourcesanspro-ttf').

meta_pkg(desktop, freebsd, [
	freebsd_conf_desktop,
	feh, dunst, xclip, xsel, scrot, unclutter, bspwm,
	'gnome-themes-standard', webfonts, fira, noto, paratype, 'sourcecodepro-ttf', 'sourcesanspro-ttf',
	sterm, zathura
]).
