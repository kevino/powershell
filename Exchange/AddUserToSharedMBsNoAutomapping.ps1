# Add user to list of Shared Mailboxes without auto-mapping
# List all the Shared Mailboxes to add the user to. Use the alias parameter (ex. Share.Vancouver).
$mbList = @("Example.City","Example.City")

# Provide the user's alias (ex. David.Brent)
$user = "Name.Surname"

foreach ($mb in $mbList) {
    Add-MailboxPermission -Identity $mb -User $user -AccessRight FullAccess -InheritanceType All -Automapping $false
    }