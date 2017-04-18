# Get Members of an SG
$groupname = Read-Host -Prompt 'Enter the name of the SG'
Get-ADGroupMember $groupname | Select DisplayName | Sort -Property DisplayName | Out-File -Filepath "$($groupname)_members.txt"