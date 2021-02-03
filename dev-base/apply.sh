#!/bin/sh
echo "==> Installing dev-base"

mkdir -p ~/.tmp
mkdir -p ~/.config

git_name="$(git config --global user.name)"
git_email="$(git config --global user.email)"
cat gitconfig > ~/.gitconfig
git config --global user.name "$git_name"
git config --global user.email "$git_email"
# custom less flag to skip adding no-init flag which ruins page up/down
[ -x "$(command -v delta)" ] && \
	git config --global core.pager "env BAT_PAGER='less -R' delta --plus-color=#104010 --theme='zenburn'"
[ -x "$(command -v interactive-rebase-tool)" ] && \
	git config --global sequence.editor interactive-rebase-tool
[ -x "$(command -v /usr/local/share/git-core/contrib/credential/libsecret/git-credential-libsecret)" ] && \
	git config --global credential.helper /usr/local/share/git-core/contrib/credential/libsecret/git-credential-libsecret

cat gitignore > ~/.gitignore

cat hgrc > ~/.hgrc

sed -e "s/^#.*$//" < ctags > ~/.ctags

cat curlrc > ~/.curlrc

cat inputrc > ~/.inputrc

cat lesskey > ~/.lesskey
lesskey

cat ripgreprc > ~/.config/ripgreprc

cat psqlrc > ~/.psqlrc

cat rc > ~/.rc

mkdir -p ~/.ssh
cat ssh_config > ~/.ssh/config

echo "==> Installed dev-base"
