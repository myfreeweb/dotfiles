echo "==> Installing dev-base"

rm ~\.gitconfig
cp gitconfig ~\.gitconfig

rm ~\.gitignore
cp gitignore ~\.gitignore

rm ~\.ackrc
cp ackrc ~\.ackrc

rm ~\.ctags
cp ctags ~\.ctags

mkdir -Force ~\.tmp

echo "==> Installed dev-base"
