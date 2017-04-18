$mailbox = Read-Host -Prompt 'Enter email address for user to disable'

Get-Mailbox -Identity $mailbox | Set-Clutter -enable $false