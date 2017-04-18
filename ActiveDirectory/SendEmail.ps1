# Send an email 

$timeNow = get-date -format "yyyy-MM-dd HH:mm"
$PSEmailServer = "mail.contoso.com"
$mailFrom = "user.name@contoso.com"
$mailCred = "contoso\user.name"
$mailTo = "test@contoso.com"

$mailSub = "PS test $timeNow"

$mailBody = (Get-Host | out-string)

Send-MailMessage -to $mailTo -from $mailFrom -subject $mailSub -body $mailBody -credential $mailCred