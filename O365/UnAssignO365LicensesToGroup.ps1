#2016-01-07 - Updated the script with a new function to support nested groups.
#Import Required PowerShell Modules
#Note - the Script Requires PowerShell 3.0!
Import-Module MSOnline
  
#Office 365 Admin Credentials
$CloudCred = Get-Credential -Credential adminuser@CONTOSO.onmicrosoft.com
 
#Connect to Office 365 
Connect-MsolService -Credential $CloudCred
function Get-JDMsolGroupMember { 
    param(
        [CmdletBinding(SupportsShouldProcess=$true)]
        [Parameter(Mandatory=$true, ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [ValidateScript({Get-MsolGroup -ObjectId $_})]
        $ObjectId,
        [switch]$Recursive
    )
    begin {
        $MSOLAccountSku = Get-MsolAccountSku -ErrorAction Ignore -WarningAction Ignore
        if (-not($MSOLAccountSku)) {
            throw "Not connected to Azure AD, run Connect-MsolService"
        }
    } 
    process {
        $UserMembers = Get-MsolGroupMember -GroupObjectId $ObjectId -MemberObjectTypes User -All
        if ($PSBoundParameters['Recursive']) {
            $GroupsMembers = Get-MsolGroupMember -GroupObjectId $ObjectId -MemberObjectTypes Group -All
            $GroupsMembers | ForEach-Object -Process {
                $UserMembers += Get-JDMsolGroupMember -Recursive -ObjectId $_.ObjectId 
            }
        }
        Write-Output ($UserMembers | Sort-Object -Property EmailAddress -Unique) 
         
    }
    end {
     
    }
}
 
  
$Licenses = @{
                 'E3' = @{ 
                          LicenseSKU = 'CONTOSOTENANT:ENTERPRISEPACK_FACULTY'
                          Group = 'O365.License.Remove'
                        }                           
            }
  
foreach ($license in $Licenses.Keys) {
  
    $GroupName = $Licenses[$license].Group
    $GroupID = (Get-MsolGroup -All | Where-Object {$_.DisplayName -eq $GroupName}).ObjectId
    $AccountSKU = Get-MsolAccountSku | Where-Object {$_.AccountSKUID -eq $Licenses[$license].LicenseSKU}
  
    Write-Output "Checking for licensed $license users in group $GroupName with ObjectGuid $GroupID..."
  
    $GroupMembers = (Get-JDMsolGroupMember -ObjectId $GroupID -Recursive | Where-Object {$_.IsLicensed -eq $true}).EmailAddress
  
    foreach ($User in $GroupMembers) {
          Try {
            Set-MsolUser -UserPrincipalName $User -ErrorAction Stop -WarningAction Stop
            Set-MsolUserLicense -UserPrincipalName $User -RemoveLicenses $AccountSKU.AccountSkuId -ErrorAction Stop -WarningAction Stop
            Write-Output "Successfully unlicensed $User with $license"
          } catch {
            Write-Warning "Error when unlicensing $User`r`n$_"
          }
          
        }
  
}