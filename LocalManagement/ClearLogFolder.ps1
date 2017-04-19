<# 
.SYNOPSIS 
    Clears a log folder at a set interval
.DESCRIPTION 
    Get items older than a certain date and removes them from a given directory. Useful for removing log files.
.NOTES
    Author       : kevino 
    Created      : 2016-04-19
    Last Updated : 
    Updated By   : 
.EXAMPLE 
    ClearLogFolder.ps1
#> 

$extensionToRemove = 'log'
$folderLocation = "C:\inetpub\logs\LogFiles\"
$daysToKeep = -14

Get-ChildItem $folderLocation -Include *.$extensionToRemove -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($daysToKeep)} | Remove-Item