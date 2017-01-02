#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
# Thanks:
#  https://cooltrainer.org/a-freebsd-desktop-howto/
#  https://github.com/pcbsd/freebsd/blob/master/etc/sysctl.conf

. common.sh

boot_set hw.usb.no_boot_wait=1 \
	kern.cam.scsi_delay=1000 \
	autoboot_delay=1 \
	compat.linuxkpi.enable_fbc=0 \
	hw.pci.do_power_nodriver=3 \
	hw.psm.synaptics_support=1 \
	hw.psm.trackpoint_support=1 \
	aesni_load="YES" \
	fuse_load="YES" \
	sem_load="YES" \
	coretemp_load="YES" \
	tpm_load="YES" \
	kern.hz="100"

sysctl_set kern.ipc.shm_allow_removed=1 \
	kern.ipc.shmmax=67108864 \
	kern.ipc.shmall=32768 \
	kern.sched.preempt_thresh=224 \
	kern.maxfiles=200000 \
	kern.ipc.shm_allow_removed=1 \
	kern.shutdown.poweroff_delay=500 \
	kern.evdev.rcpt_mask=12 \
	vfs.usermount=1 \
	hw.snd.default_auto=1 \
	hw.usb.no_shutdown_wait=1 \
	net.inet6.ip6.use_tempaddr=1 \
	net.inet6.ip6.prefer_tempaddr=1 \
	hw.psm.synaptics.softbuttons_y="-1700" # X240 clickpad

sysrc background_dhclient="YES" \
	syslogd_flags="-ss" \
	powerdxx_enable="YES" \
	performance_cx_lowest="Cmax" \
	economy_cx_lowest="Cmax" \
	devfs_system_ruleset="desktop" \
	pf_enable="YES" \ 
	sendmail_enable="NONE" \
	smtpd_enable="YES"

cat pf_desktop.conf > /etc/pf.conf
cat devfs_desktop.rules > /etc/devfs.rules

pkg install -y gmake-lite automake autoconf libidn libiconv gettext-runtime gettext-tools p5-Locale-gettext mime-support db5 cyrus-sasl gpgme

pkg info opensmtpd >/dev/null || make BATCH=yes WITH="MAILERCONF" -C /usr/ports/mail/opensmtpd install clean
pkg lock -y opensmtpd
cat smtpd_desktop.conf > /usr/local/etc/mail/smtpd.conf

pkg install -y \
	powerdxx ack ctags mercurial sloccount npm \
	urlview hashcash notmuch antiword w3m neomutt \
	py27-ranger py27-pip python36 rubygem-bundler \
	xorg compton unclutter xautolock slock sterm \
	zathura zathura-ps zathura-djvu zathura-pdf-poppler \
	feh dunst rofi xclip xsel maim slop pngquant xev redshift automount OpenSSH-askpass \
	xdotool xvkbd transset surf-browser meld gvolwheel \
	gnome-themes-standard qt5ct \
	fira noto paratype sourcecodepro-ttf sourcesanspro-ttf inconsolata-ttf fantasque-sans-mono \
	droid-fonts-ttf roboto-fonts-ttf comic-neue clearsans \

python3.6 -m ensurepip --upgrade --user

pkg info webfonts >/dev/null || make BATCH=yes WITH=MSWINDOWS_LICENSE -C /usr/ports/x11-fonts/webfonts install clean
pkg lock -y webfonts
