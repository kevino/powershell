<# 
.SYNOPSIS 
    Enables Remote management through powershell
.DESCRIPTION 
    Pass the script a computername as a parameter and it will attempt to connect to that computer and enable PowershellRemoting
.NOTES
    Author       : kevino 
    Created      : 2016-04-19
    Last Updated : 
    Updated By   : 
.EXAMPLE 
    EnablePSRemotingRemotely.ps1 "EXAMPLEPC.CONTOSO.COM"
#> 
param([string]$targetComputer)

psexec.exe \\$targetComputer -s powershell Enable-PSRemoting -Force

enter-pssession -ComputerName $targetComputer