# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://github.com/jayharris/dotfiles-windows

Import-Module PsGet
Import-Module PsReadLine
Import-Module posh-git

Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Misc
function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }
function touch($file) { "" | Out-File $file -Encoding ASCII }
function sudo() {
	if ($args.Length -eq 1) {
		start-process $args[0] -verb "runAs"
	}
	if ($args.Length -gt 1) {
		start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
	}
}
# Reload the Shell
function Reload-Powershell {
	$newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
	[System.Diagnostics.Process]::Start($newProcess);
	exit
}
Set-Alias time Measure-Command
function CreateAndSet-Directory([String] $path) { New-Item $path -ItemType Directory -ErrorAction SilentlyContinue; Set-Location $path }
Set-Alias mcd CreateAndSet-Directory
Set-Alias reload Reload-Powershell
Set-Alias g git
Set-Alias vi vim
Set-Alias l ls
${function:la} = { ls -Force @args }
