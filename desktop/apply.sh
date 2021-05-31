#!/bin/sh
echo "==> Installing desktop"

mkdir -p ~/.local/bin

install_bin() {
	cat "$1" > "$HOME/.local/bin/$1"
	chmod +x "$HOME/.local/bin/$1"
}

install_bin startw

cat XCompose > ~/.XCompose

mkdir -p ~/.config/fontconfig
cat fonts.xml > ~/.config/fontconfig/fonts.conf

mkdir -p ~/.config/gtk-2.0
cat gtkrc.mine > ~/.config/gtk-2.0/gtkrc

mkdir -p ~/.config/alacritty
cat alacritty.yml > ~/.config/alacritty/alacritty.yml

ln -sf ../../../.config/mimeapps.list ~/.local/share/applications/mimeapps.list
xdg-mime default eog.desktop image/jpeg image/png image/bmp image/x-bmp image/gif image/tiff image/x-pcx
xdg-mime default io.github.GnomeMpv.desktop application/ogg application/x-ogg video/mpeg video/x-mpeg video/x-mpeg2 video/mp4 video/msvideo video/x-msvideo video/ogg video/quicktime video/vnd.rn-realvideo video/x-ms-afs video/x-ms-asf video/x-ms-wmv video/x-ms-wmx video/x-ms-wvxvideo video/x-avi video/x-fli video/x-flv video/x-theora video/x-matroska video/webm video/x-ogm+ogg
xdg-mime default org.gnome.Nautilus.desktop inode/directory
xdg-mime default org.gnome.Evince.desktop application/pdf image/vnd.djvu image/x-djvu application/x-dvi application/vnd.comicbook+zip application/vnd.comicbook-rar application/oxps application/vnd.ms-xpsdocument application/postscript application/eps application/x-eps image/eps image/x-eps
xdg-mime default libreoffice-writer.desktop application/vnd.oasis.opendocument.text application/vnd.oasis.opendocument.text-template application/vnd.oasis.opendocument.text-web application/vnd.oasis.opendocument.text-master application/vnd.oasis.opendocument.text-master-template application/vnd.openxmlformats-officedocument.wordprocessingml.document application/msword
xdg-mime default libreoffice-calc.desktop application/vnd.oasis.opendocument.spreadsheet application/vnd.oasis.opendocument.spreadsheet-template application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-excel
xdg-mime default libreoffice-impress.desktop application/vnd.oasis.opendocument.presentation application/vnd.oasis.opendocument.presentation-template

mkdir -p ~/.config/beets
cat beets.yml > ~/.config/beets/config.yaml

echo "==> Installed desktop"
