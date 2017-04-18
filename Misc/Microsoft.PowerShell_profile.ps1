# Update help documentation
# Update-Help

# If running as admin change text colour
if($Host.UI.RawUI.WindowTitle -like "*administrator*")
{
	$Host.UI.RawUI.ForegroundColor = "Green"
}

function Global:prompt {"PS [$Env:username] @ " + (get-date -uformat "%Y-%m-%d %T in ") + (get-item .)+ "`n>"}

Set-Location "\\PATH\GitHub\powershell"

Clear-Host

# Start a Transcript
Start-Transcript -OutputDirectory "C:\output\transcripts\"

Write-Host "`n"