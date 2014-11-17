% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

pkg(freebsd_conf_desktop).
depends(freebsd_conf_desktop, _, [freebsd_conf_common]).
:- dynamic freebsd_conf_desktop_set/0.
met(freebsd_conf_desktop, _) :- freebsd_conf_desktop_set.
meet(freebsd_conf_desktop, freebsd) :-
	sudo_sh(['sysrc ',
	'background_dhclient=YES moused_enable=YES ',
	'powerd_enable=YES powerd_flags="-a hiadaptive -b adaptive" ',
	'>/dev/null']),
	sudo_sh(['sysrc -f /etc/sysctl.conf ',
	'kern.ipc.shm_allow_removed=1 kern.ipc.shmmax=67108864 kern.ipc.shmall=32768 ',
	'kern.sched.preempt_thresh=224 kern.maxfiles=200000 hw.syscons.bell=0 vfs.usermount=1 ',
	'>/dev/null']),
	sudo_sh(['sysrc -f /boot/loader.conf ',
	'tmpfs_load=YES aio_load=YES libiconv_load=YES libmchain_load=YES ',
	'cd9660_iconv_load=YES msdosfs_iconv_load=YES fuse_load=YES snd_driver_load=YES ',
	'>/dev/null']),
	sudo_sh('cat ./marelle-tpls/make.conf ./marelle-tpls/make.desktop.conf > /etc/make.conf'),
	sudo_sh('cat ./marelle-tpls/pf.desktop.conf > /etc/pf.conf'),
	assertz(freebsd_conf_desktop_set).


pkg(freetype2).
installs_with_ports(freetype2, 'print/freetype2', 'WITH="LCD_FILTERING"').

pkg(xserver).
depends(xserver, freebsd, [freetype2]).
installs_with_ports(xserver, 'x11-servers/xorg-server', 'WITH="DEVD" WITHOUT="HAL"').

pkg(xorg).
depends(xorg, freebsd, [xserver]).
installs_with_ports(xorg, 'x11/xorg', 'WITHOUT="DOCS"').

pkg(vbox_client).
depends(vbox_client, freebsd, [xorg]).
installs_with_pkgng(vbox_client, 'emulators/virtualbox-ose-additions').

pkg(vbox_client_enabled).
depends(vbox_client_enabled, freebsd, [vbox_client]).
:- dynamic vbox_client_enabled_set/0.
met(vbox_client_enabled, _) :- vbox_client_enabled_set.
meet(vbox_client_enabled, freebsd) :-
	sudo_sh('sysrc vboxguest_enable=YES vboxservice_enable=YES >/dev/null'),
	assertz(vbox_client_enabled_set).

pkg(xorg_conf).
depends(xorg_conf, freebsd, [xorg, vbox_client_enabled]).
:- dynamic xorg_conf_set/0.
met(xorg_conf, _) :- xorg_conf_set.
meet(xorg_conf, freebsd) :-
	sudo_sh('cat ./marelle-tpls/xorg.vbox.conf ./marelle-tpls/xorg.conf > /etc/X11/xorg.conf'),
	assertz(xorg_conf_set).

managed_pkg(xcompmgr).
depends(xcompmgr, freebsd, [xorg]).

pkg(xmonad).
depends(xmonad, freebsd, [xcompmgr, xorg_conf]).
installs_with_pkgng(xmonad, 'x11-wm/hs-xmonad').

pkg(xmonad_contrib).
depends(xmonad_contrib, freebsd, [xmonad]).
installs_with_pkgng(xmonad_contrib, 'x11-wm/hs-xmonad-contrib').

pkg(xmobar).
depends(xmobar, freebsd, [xorg_conf]).
installs_with_ports(xmobar, 'x11/hs-xmobar', 'WITH="LLVM THREADED XFT"').

pkg(dmenu).
depends(dmenu, freebsd, [xorg_conf]).
installs_with_ports(dmenu, 'x11/dmenu', 'WITH="XFT"').

managed_pkg(feh).
managed_pkg(clearlooks).
pkg(webfonts).
installs_with_ports(webfonts, 'x11-fonts/webfonts', 'WITH="MSWINDOWS_LICENSE"').
managed_pkg(urwfonts).
managed_pkg(fira).
managed_pkg(noto).
managed_pkg(paratype).
managed_pkg('sourcecodepro-ttf').
managed_pkg('sourcesanspro-ttf').
managed_pkg('rxvt-unicode').
managed_pkg(firefox).

meta_pkg(desktop, freebsd, [
	freebsd_conf_desktop,
	shell, dev, mail,
	xorg_conf, xmonad, xmobar, dmenu, feh,
	clearlooks, webfonts, urwfonts, fira, noto, paratype, 'sourcecodepro-ttf', 'sourcesanspro-ttf',
	'rxvt-unicode', firefox
]).
