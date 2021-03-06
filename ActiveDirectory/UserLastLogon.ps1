# Gets time stamps for all User in the domain that have NOT logged in since after specified date 
# Mod by Tilo 2014-04-01 
import-module activedirectory  
$DaysInactive = 90  
$time = (Get-Date).Adddays(-($DaysInactive)) 
$ou = "OU=[User Accounts - Enabled],DC=CONTOSO,DC=com"
  
# Get all AD User with lastLogonTimestamp less than our time and set to enable 
Get-ADUser -Searchbase $ou -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp | Sort LastLogonTimeStamp |
  
# Output Name and lastLogonTimestamp into CSV  
select-object DistinguishedName,@{Name="Last Logon Date"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd')}} | export-csv LastLogon\olduser.csv -notypeinformation