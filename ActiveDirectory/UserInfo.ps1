# Gets a list of users that have been active in the past 120 days and outputs info about that user

# Import AD functions
import-module activedirectory  

# Set up date logic for later
$DaysInactive = 120  
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD Users with lastLogonTimestamp more recent than 120 days ago and collect a bunch of info, sorted by name
Get-ADUser -Server gc.contoso.com:3268 -Filter {LastLogonTimeStamp -gt $time -and enabled -eq $true} -Properties LastLogonTimeStamp,co,l,department,manager,cn,title,distinguishedName | Sort cn |
  
# Output data into CSV  
select-object cn,co,l,department,title,manager,distinguishedName,@{Name="Last Logon Date"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd')}} | 
export-csv c:\temp\userinfo.csv -notypeinformation