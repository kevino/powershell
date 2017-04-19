<# 
.SYNOPSIS 
    Pass the a directory as the argument and it will add it to your $env:PATH
.DESCRIPTION 
    
.NOTES
    Author       : kevino 
    Created      : 2016-04-19
    Last Updated : 
    Updated By   : 
.EXAMPLE 
    AddtoPath.ps1 "C:\Useful EXEs\"
#> 

param([string]$pathToAdd)

$env:PATH += ";$pathToAdd"