#2016-01-07 - Updated the script with a new function to support nested groups.
#Import Required PowerShell Modules
#Note - the Script Requires PowerShell 3.0!
Import-Module MSOnline
  
#Office 365 Admin Credentials
$CloudCred = Get-Credential -Credential adminuser@contoso.onmicrosoft.com
 
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
                          Group = 'O365.License.All'
                        } 
            }
$UsageLocation = 'CA'
  
foreach ($license in $Licenses.Keys) {
  
    $GroupName = $Licenses[$license].Group
    $GroupID = (Get-MsolGroup -All | Where-Object {$_.DisplayName -eq $GroupName}).ObjectId
    $AccountSKU = Get-MsolAccountSku | Where-Object {$_.AccountSKUID -eq $Licenses[$license].LicenseSKU}
  
    Write-Output "Checking for unlicensed $license users in group $GroupName with ObjectGuid $GroupID..."
  
    $GroupMembers = (Get-JDMsolGroupMember -ObjectId $GroupID -Recursive | Where-Object {$_.IsLicensed -eq $false}).EmailAddress
  
    if ($AccountSKU.ActiveUnits - $AccountSKU.consumedunits -lt $GroupMembers.Count) { 
        Write-Warning 'Not enough licenses for all users, please remove user licenses or buy more licenses'
      }
         
        foreach ($User in $GroupMembers) {
          Try {
            Set-MsolUser -UserPrincipalName $User -UsageLocation $UsageLocation -ErrorAction Stop -WarningAction Stop
            # adds the license identified in the Licenses array and the free powerBI
            Set-MsolUserLicense -UserPrincipalName $User -AddLicenses $AccountSKU.AccountSkuId,CONTOSOTENANT:POWER_BI_STANDARD -ErrorAction Stop -WarningAction Stop
            Write-Output "Successfully licensed $User with $license"
          } catch {
            Write-Warning "Error when licensing $User`r`n$_"
          }
          
        }
  
}