Set-ExecutionPolicy RemoteSigned
Set-AdServerSettings -ViewEntireForest $true

$mbToConvert = "example@CONTOSO.com"

Set-Mailbox $mbToConvert -Type Shared

Write-Host "All Done" -foregroundcolor green -BackgroundColor black