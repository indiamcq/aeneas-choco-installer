#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one
Set-ExecutionPolicy Bypass
# stop on all errors
$ErrorActionPreference = 'Stop';


$packageName = 'vcpluspluspython27-win10' # arbitrary name for the package, used in messages
$registryUninstallerKeyName = 'Microsoft Visual C++ Compiler for Python 2.7' #ensure this is the value in the registry
$installerType = 'MSI' #only one of these: exe, msi, msu
$url = 'https://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi' # download url
$url64 = '$url' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/q' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# main helper functions - these have error handling tucked into them already
# see https://github.com/chocolatey/choco/wiki/HelpersReference
# Install an application, will assert administrative rights
# add additional optional arguments as necessary
#Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" ["$url64"  -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64]
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
