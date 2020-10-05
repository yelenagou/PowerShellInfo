#$ComputerName = Read-Host "Enter Computername"
Get-CimInstance  -ClassName Win32_OperatingSystem |
    Select-Object CSName, LastBootUpTime