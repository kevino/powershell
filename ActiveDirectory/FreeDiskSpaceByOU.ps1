$ou = "OU=Class Computers - Teachers,OU=[Hardware-Workstations],,DC=CONTOSO,DC=COM"
$computers = Get-AdComputer -Filter '*' -SearchBase $ou
$computers |
foreach {
Get-WMIObject Win32_Logicaldisk -filter "deviceid='C:'" -ComputerName $_ 
} | 
Select PSComputername,DeviceID,
@{Name="SizeGB";Expression={$_.Size/1GB -as [int]}},
@{Name="FreeGB";Expression={[math]::Round($_.Freespace/1GB,2)}},
@{Name="Free%";Expression={[math]::Round($_.Freespace/$_.Size*100,2)}} |
Sort Free% | 
Format-Table -AutoSize | 
Out-File -Filepath "freespace.txt"