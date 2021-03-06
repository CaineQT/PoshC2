﻿# To install or upgrade PoshC2 run the following command in PowerShell
# 
# powershell -exec bypass -c "iex (new-object system.net.webclient).downloadstring('https://raw.githubusercontent.com/nettitude/PoshC2/master/C2-Installer.ps1')"

function Download-File 
{
    Param
    (
        [string]
        $From,
        [string]
        $To
    )
    (new-object system.net.webclient).DownloadFile($From,$To)
}

function Unzip-File
{
    Param
    (
        [string]
        $file,
        [string]
        $destination
    )
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace($file)
	foreach($item in $zip.items())
	{
		$shell.Namespace($destination).copyhere($item)
	}
}

$downloadpath = "https://github.com/nettitude/PoshC2/archive/master.zip"
$installpath = "C:\Temp\"
    
$pathexists = Test-Path $installpath
if (!$pathexists) {
New-Item $installpath -Type Directory 
}

Download-File -From $downloadpath -To "$($installpath)PoshC2-master.zip"
Unzip-File "$($installpath)PoshC2-master.zip" $installpath
Remove-Item "$($installpath)PoshC2-master.zip"
$pathexists = Test-Path "$($installpath)PowershellC2"
if (!$pathexists) {
Move-Item "$($installpath)PoshC2-master" "$($installpath)PowershellC2"
} else {
Remove-Item "$($installpath)PowershellC2" -Recurse
Move-Item "$($installpath)PoshC2-master" "$($installpath)PowershellC2"
}