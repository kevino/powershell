$domainCredentials = Get-Credential

$computerName = 'COMPUTERNAME.CONTOSO.com'
$sourceFile = "\\CONTOSO.com\PATHTOINSTALLER\APPLICATION.msi"

$destinationFolder = "\\$computerName\C$\Temp"
	
Invoke-Command -ComputerName $computerName -Credential $domainCredentials -ScriptBlock { Msiexec /i $sourceFile /log C:\MSIInstall.log }