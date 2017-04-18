$cred = Get-Credential -Credential CONTOSO\administrator
# Get-Content c:\temp\computerlist.txt | Select-Object @{Name='ComputerName';Expression={$_}},@{Name='FolderExist';Expression={Test-Path -path "\\$_\c$\Program Files\Microsoft Office\Office 15" -Credential $cred}}
Test-Path -path "\\COMPUTERNAME.CONTOSO.com\c$\Program Files\Microsoft Office\Office15" -Credential $cred