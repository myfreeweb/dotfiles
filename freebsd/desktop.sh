#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
# Thanks:
#  https://cooltrainer.org/a-freebsd-desktop-howto/
#  https://github.com/pcbsd/freebsd/blob/master/etc/sysctl.conf

. common.sh

sysctl_set kern.ipc.shm_allow_removed=1
sysctl_set kern.ipc.shmmax=67108864
sysctl_set kern.ipc.shmall=32768
sysctl_set kern.sched.preempt_thresh=224
sysctl_set kern.maxfiles=200000
sysctl_set kern.ipc.shm_allow_removed=1
sysctl_set kern.shutdown.poweroff_delay=500
sysctl_set vfs.usermount=1
sysctl_set hw.syscons.bell=0
sysctl_set hw.snd.default_auto=1
sysctl_set hw.usb.no_shutdown_wait=1
sysctl_set net.inet6.ip6.use_tempaddr=1
sysctl_set net.inet6.ip6.prefer_tempaddr=1
sysctl_set net.inet.ip.fastforwarding=1 # NOTE: breaks IPSec

sysrc background_dhclient="YES"
sysrc syslogd_flags="-ss"

make BATCH=yes WITH="LCD_FILTERING PNG" -C /usr/ports/x11-fonts/webfonts install clean

pkg install ack ctags mercurial bazaar sloccount npm \
	xorg compton unclutter xautolock slock bspwm sterm \
	zathura zathura-ps zathura-djvu zathura-pdf-mupdf \
	feh dunst xclip xsel scrot \
	gnome-themes-standard \
	fira noto paratype sourcecodepro-ttf sourcesanspro-ttf

make BATCH=yes WITH=MSWINDOWS_LICENSE -C /usr/ports/x11-fonts/webfonts install clean
