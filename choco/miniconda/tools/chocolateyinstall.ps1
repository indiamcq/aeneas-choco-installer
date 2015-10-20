#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = 'Stop';


$BinRoot = Get-BinRoot
 
$PackageName = 'Miniconda'
$InstallerType = 'EXE'
$Url = 'https://repo.continuum.io/miniconda/Miniconda-3.9.1-Windows-x86.exe'
$Url64 = 'https://repo.continuum.io/miniconda/Miniconda-3.9.1-Windows-x86_64.exe'
$Args = "/InstallationType=AllUsers /S /D=$BinRoot\Miniconda\"
$ValidExitCodes = @(0)
 
Install-ChocolateyPackage "$PackageName" "$InstallerType" "$Args" "$Url" "$Url64"  -validExitCodes $ValidExitCodes