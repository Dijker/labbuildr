﻿<#
.Synopsis
   Short description
.DESCRIPTION
   labbuildr is a Self Installing Windows/Networker/NMM Environemnt Supporting Exchange 2013 and NMM 3.0
.LINK
   https://community.emc.com/blogs/bottk/2014/06/16/announcement-labbuildr-released
#>
#requires -version 3
[CmdletBinding()]
param (
$sp_version= "SP2013sp1fndtn",
$SourcePath = "\\vmware-host\Shared Folders\Sources",
$Setupcmd = "Setup.exe"
)
$ScriptName = $MyInvocation.MyCommand.Name
$Host.UI.RawUI.WindowTitle = "$ScriptName"
$Builddir = $PSScriptRoot
$Logtime = Get-Date -Format "MM-dd-yyyy_hh-mm-ss"
New-Item -ItemType file  "$Builddir\$ScriptName$Logtime.log"
.$Builddir\test-sharedfolders.ps1
$Setuppath = "$SourcePath\$sp_version\$Setupcmd"
.$Builddir\test-setup.ps1 -setup "Sharepoint 2013" -setuppath $Setuppath
$arguments = "/config `"$Sourcepath\$sp_version\files\setupsilent\config.xml`""
Write-Warning "Installing Sharepoint may take up to 25 Minutes"
Start-Process $Setuppath -ArgumentList $arguments -Wait
Write-Verbose "Setting Sharepoint VSS Writer"
Start-Process "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\BIN\STSADM.EXE" -ArgumentList "-o registerwsswriter" -Wait
Get-Service SPWriterV4 | Set-Service -StartupType Automatic
Start-Service SPWriterV4 -Verbose