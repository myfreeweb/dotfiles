echo "==> Installing vim"

mkdir -Force ~\.vim
mkdir -Force ~\.vim\tmp
mkdir -Force ~\.vim\tmp\undo
mkdir -Force ~\.vim\tmp\backups
mkdir -Force ~\.vim\bundle
mkdir -Force ~\.vim\autoload
(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim") | % {$_.replace("`n", "`r`n")} | Out-File -Encoding utf8 ~\.vim\autoload\plug.vim

rm ~\.vimrc
cp vimrc ~\.vimrc

rm ~\.vim\*.vim
cp .\*.vim ~\.vim\

rm -Recurse -Force ~\.vim\ftplugin
cp -Recurse -Force ftplugin ~\.vim\ftplugin

rm -Recurse -Force ~\.vim\syntax
cp -Recurse -Force syntax ~\.vim\syntax

vim +PlugUpdate +qall

echo "==> Installed vim"
