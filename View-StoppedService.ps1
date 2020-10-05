$Computername = Read-Host 'Enter name of hostname'
$StoppedService = get-service -ComputerName $Computername |
    Where-Object -Property Status -EQ 'Stopped'
Write-Output $StoppedService