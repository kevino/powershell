#Rename local computer
$newName = Read-Host "What is the new computer name?"

Rename-Computer -NewName $newName