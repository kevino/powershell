Set-AdServerSettings -ViewEntireForest $true
$mailbox = Read-Host -Prompt 'Enter the alias for the mailbox to be exported'
New-MailboxExportRequest -Mailbox $mailbox -filepath $("\\mail.contoso.com\a$\ExportedMailboxes\" + $mailbox + "_Export.pst")
New-MailboxExportRequest -Mailbox $mailbox -IsArchive -filepath $("\\mail.contoso.com\a$\ExportedMailboxes\" + $mailbox + "_Export_Archive.pst")