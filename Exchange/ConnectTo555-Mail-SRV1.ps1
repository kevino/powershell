Set-ExecutionPolicy RemoteSigned

$UserCredential = Get-Credential
$serverConnection = http://mail.CONTOSO.com/PowerShell/
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $serverConnection -Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

Write-Host "`nRemember to remove your session at the end by entering " -BackgroundColor black -nonewline; Write-Host "Remove-PSSession `$Session" -foregroundcolor green -backgroundcolor black