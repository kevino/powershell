Set-ExecutionPolicy RemoteSigned
Set-AdServerSettings -ViewEntireForest $true

$sgToConvert = "SharedMailboxes.Global"

Enable-DistributionGroup $sgToConvert