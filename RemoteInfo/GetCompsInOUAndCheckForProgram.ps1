﻿Get-Credential $cred
Get-ADComputer -Filter * -Server gc.CONTOSO.com -SearchBase "OU=Kiosks,OU=[Hardware-Workstations],DC=CONTOSO,DC=com" | Test-Path -Credential $cred -Path "\\$_\C$\Program Files\Microsoft Office\Office15"