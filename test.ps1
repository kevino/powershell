$fileExe = "\\contoso.com\deploy\BGInfo\bginfo.exe"
$fileConfig = "\\contoso.com\deploy\BGInfo\ACAVAN-config.bgi"

& $fileExe $fileConfig /timer:0 /silent /nolicprompt
