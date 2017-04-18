Set-ExecutionPolicy RemoteSigned
$appPoolsArray = @("MSEXchangeRpcProxyAppPool","MSEXchangeRpcProxyFrontEndAppPool","MSEXchangeAutodiscoverAppPool")
Write-Host "`nRecycling the AppPools For Post Mailbox Migration" -foregroundcolor green -BackgroundColor black
foreach ($appPool in $appPoolsArray) {
    Restart-WebAppPool $appPool
    }
Write-Host "All Done" -foregroundcolor green -BackgroundColor black
Read-Host -Prompt "Press Enter to exit"