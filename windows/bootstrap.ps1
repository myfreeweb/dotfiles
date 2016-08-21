# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://github.com/jayharris/dotfiles-windows

# Get the ID and security principal of the current user account
$myIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myPrincipal = new-object System.Security.Principal.WindowsPrincipal($myIdentity)

# Check to see if we are currently running "as Administrator"
if (!$myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
	$newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
	$newProcess.Arguments = $myInvocation.MyCommand.Definition;
	$newProcess.Verb = "runas";
	[System.Diagnostics.Process]::Start($newProcess);
	exit
}

########### Settings
# Sound: Disable Startup Sound
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DisableStartupSound" 1
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" "DisableStartupSound" 1

# Explorer: Show hidden files by default (1: Show Files, 2: Hide Files)
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1
# Explorer: show file extensions by default (0: Show Extensions, 1: Hide Extensions)
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0
# Explorer: show path in title bar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Type Folder | Out-Null
}
# Explorer: Avoid creating Thumbs.db files on network volumes
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailsOnNetworkFolders" 1


########### Visual Studio
if (($env:VSINSTALLDIR -ne $null) -and (Test-Path $env:VSINSTALLDIR)) {
	$vsInstall = $env:VSINSTALLDIR
	function Install-VSExtension($url) {
		$vsixInstaller = Join-Path $env:DevEnvDir "VSIXInstaller.exe"
		Write-Output "Downloading ${url}"
		$extensionFile = (curlex $url)
		Write-Output "Installing $($extensionFile.Name)"
		$result = Start-Process -FilePath `"$vsixInstaller`" -ArgumentList "/q $($extensionFile.FullName)" -Wait -PassThru;
	}
	# VsVim
	Install-VSExtension https://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/54/VsVim.vsix
	# Visual F# Power Tools
	Install-VSExtension https://visualstudiogallery.msdn.microsoft.com/136b942e-9f2c-4c0b-8bac-86d774189cff/file/124201/24/FSharpVSPowerTools.vsix
	# F# Empty Windows App (WPF)
	Install-VSExtension https://visualstudiogallery.msdn.microsoft.com/e0907c99-bb04-4eb8-9692-9333d5ff4399/file/64880/17/FSharpWpfEmpty.vsix
}


########### Chocolatey
function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }
if ((which cinst) -eq $null) {
	iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

cinst ack
cinst ctags
cinst git
cinst vim
cinst SourceCodePro
cinst autohotkey
cinst wincompose
cinst github
cinst curl
cinst wget

########### PowerShell plugins
Install-Package PsReadline
Install-Package PsSudo
Install-Package posh-git