# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

mkdir -Force ~\Documents\WindowsPowerShell
cp -Force profile.ps1 ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

& "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in keyboardstuff.ahk /out "$($HOME)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\keyboardstuff.exe"