#!/bin/sh
echo "==> Installing x11"

mkdir -p ~/.local/bin

install_bin() {
	cat "$1" > "$HOME/.local/bin/$1"
	chmod +x "$HOME/.local/bin/$1"
}

install_bin2() {
	cat "$1" > "$HOME/.local/bin/$2"
	chmod +x "$HOME/.local/bin/$2"
}

install_bin startw
install_bin floatyoutube
install_bin mkscreencast
install_bin mkscreenshot
install_bin freepass-x11
install_bin x-terminal-emulator
install_bin bar.rs
install_bin disable-standby-fs.py
install_bin2 volumectl.rs volumectl

cat xinitrc > ~/.xinitrc
touch ~/.xinitrc.local

cat desktoprc > ~/.desktoprc

touch ~/.Xresources.local
cat Xresources > ~/.Xresources

cat XCompose > ~/.XCompose

mkdir -p ~/.config/i3
cat i3.conf > ~/.config/i3/config

mkdir -p ~/.config/sway
cat sway.conf > ~/.config/sway/config

mkdir -p ~/.config/dunst
cat dunstrc.ini > ~/.config/dunst/dunstrc

mkdir -p ~/.config/zathura
cat zathurarc > ~/.config/zathura/zathurarc

mkdir -p ~/.config/gtk-2.0
cat gtkrc.mine > ~/.config/gtk-2.0/gtkrc

mkdir -p ~/.config/gtk-3.0
cat gtk3.ini > ~/.config/gtk-3.0/settings.ini
cat gtk3.css > ~/.config/gtk-3.0/gtk.css

mkdir -p ~/.config/fontconfig
cat fonts.xml > ~/.config/fontconfig/fonts.conf

cat compton.conf > ~/.config/compton.conf

ln -sf ../../../.config/mimeapps.list ~/.local/share/applications/mimeapps.list
xdg-mime default feh.desktop image/jpeg image/png image/bmp image/x-bmp image/gif image/tiff image/x-pcx
xdg-mime default mpv.desktop application/ogg application/x-ogg video/mpeg video/x-mpeg video/x-mpeg2 video/mp4 video/msvideo video/x-msvideo video/ogg video/quicktime video/vnd.rn-realvideo video/x-ms-afs video/x-ms-asf video/x-ms-wmv video/x-ms-wmx video/x-ms-wvxvideo video/x-avi video/x-fli video/x-flv video/x-theora video/x-matroska video/webm video/x-ogm+ogg
xdg-mime default nautilus-classic.desktop inode/directory

xrdb ~/.Xresources

echo "==> Installed x11"
