# stop on all errors
$ErrorActionPreference = 'Stop';


$packageName = 'espeak' # arbitrary name for the package, used in messages
$registryUninstallerKeyName = 'eSpeak version 1.48.04' #ensure this is the value in the registry
$installerType = 'EXE' #only one of these: exe, msi, msu
$url = 'http://sourceforge.net/projects/espeak/files/espeak/espeak-1.48/setup_espeak-1.48.04.exe/download' # download url
#$url64 = '{{DownloadUrlx64}}' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/SILENT' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# main helper functions - these have error handling tucked into them already
# see https://github.com/chocolatey/choco/wiki/HelpersReference
# Install an application, will assert administrative rights
# add additional optional arguments as necessary
#Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" ["$url64"  -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64]
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
Install-ChocolateyPath 'C:\Program Files (x86)\eSpeak\command_line' 'Machine' # Machine will assert administrative rights
