#join computer to domain
$domain = "contoso.com" 
$newComputerName = Read-Host -Prompt "Enter the new computer hostname"

Add-Computer -DomainName $domain -NewName $newComputerName -Credential (Get-Credential)