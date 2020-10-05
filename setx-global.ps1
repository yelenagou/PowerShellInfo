Write-host "I am running a script" -ForegroundColor Green
[int32]$global:x = Read-host "Enter a new global value for X"
Write-Host "Setting `$x to $global:x" -ForegroundColor Green

$global:x+$global:x

$y = "powershell"