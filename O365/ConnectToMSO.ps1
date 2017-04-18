<# 
.SYNOPSIS 
    Connects to MSOnline 
.DESCRIPTION 
    Takes credentials and connects to a remote session with ILSC's Azure AD. No need to disconnect manually.
.NOTES
    Author       : kevino 
    Created      : 2016-11-24
    Last Updated : 2016-11-24
    Updated By   : 
.EXAMPLE 
    ConnectToMSO.ps1
#> 

Import-Module MSOnline
$CloudCred = Get-Credential -Credential adminuser@contoso.onmicrosoft.com
Connect-MsolService -Credential $CloudCred

Get-MsolDomain