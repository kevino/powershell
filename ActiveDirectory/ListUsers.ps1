#List Users under an OU
import-module activedirectory

$ou = "OU=[User Accounts - Enabled],DC=CONTOSO,DC=com"
$server = "gc.contoso.com"

Get-ADUser -Server $server -Searchbase $ou -Filter * -Properties Name | select-object Name 