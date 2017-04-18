# ILSC.com/[Global Campus Locations]/[Australia]/[Sydney]/[User Accounts - Active]/Faculty/
# Password Reset for all teachers
#
# WIP
#

$newPass = ConvertTo-SecureString -AsPlainText "Passw0rd" -Force
$userOU = "OU=Faculty,OU=[User Accounts - Active],OU=[Sydney],OU=[Australia],OU=[Global Campus Locations],DC=CONTOSO,DC=COM"

Get-ADUser -SearchBase $userOU -Filter * | measure

write-host -nonewline "Continue? (Y/N) "
$response = read-host
if ( $response -ne "Y" ) { exit }

Get-ADUser -SearchBase $userOU -Filter * | Set-ADAccountPassword -newpassword $newPass -Reset -Confirm