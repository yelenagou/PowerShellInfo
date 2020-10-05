### Syntax
* Verb-Noun
* `Get-Help` - research and learn powershell
* `Get-Command`
* `Get-History`
### Documenting Your Work in PowerShell console

* Create a new directory:
  * `Md d:\scripts\transcripts`
    * Above command will list history of commands executed in that session
  * `invoke-history -id 11`
    * Above command will invoke a particular line from the result of executing an above command
  * `Get-History | Out-File d:\scripts\transcripts\history.txt`
    * get session history into an output file
* To start a transcript:
  * `help Start-Transcript`
  * `Start-Transcript -path .\transcripts\Transcript1.txt -append`
    * Create traffic by running following command:
    * `Get-Service | Where-Object -Property Status -eq Stopped`
    * Check the output file
## Get Object Members

* `Get-Service | Get-Member`
  
## Gathering Information with PowerShell
### Troubleshooting Made Simple
* `get-command -Name get-*Fire*`
* `get-netfirewallrule -Name *RemoteDesktop*`
* `get-NetFirewallRule -Name *RemoteDesktop* | FT`

### Gathering OS Information
#### Windows Management Instrumentation (WMI)
- Get-WMIobject
#### Common Information Model (CIM)
- `Get-CimInstance`
- Wmi Repository > CIMv2 > WIN32
- `Get-command *counter*`
  
- `get-counter -ListSet Memory`
- `get-counter --ListSet Memory | Select -Expand Counter`
- `get-counter -Counter "\Memory\Pages/sec","\Memory\% Committed Bytes in Use" | FT `
- `Get-WmiObject -List *` - WILL RETURN A HUGE LIST
- `Get-CimClass -ClassName *`
- `Get-CimClass -ClassName *memory*`
- `get-ciminstance -ClassName Win32_PhysicalMemory | Select Tag,Capacity`
#### Network Troubleshooting
- `Get-Command get-NetIP*`
- `help get-childitem`

### File and Folders
- To look through a directory:
  - `Get-ChildItem -Path D:\ -Recurse | where Extension -EQ '.png' | ft Directory,Name,LastWriteTime
`

### Remoting

`Enable-PSRemoting -force`
`Set-PSSessionConfiguraiton -Name Microsoft.PowerShell -ShowSecurityDescriptiorUI`
`Get-NetfirewallRule | Where Displayname -like "*Windows Management Instrumentation*"| Set-NetFirewallRule -Eanble Ture -Verbose`

### Buildiing a User Inventory Script with PowerShell

- Set execution policy to execute .ps1 scripts
- `Get-ExecutionPolicy`
- `Help Set-ExecutionPolicy -Parameter ExecutionPolicy`
- Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

### Get computer Name
`$env:computername`
```powershell
get-ciminstance -ClassName Win32_OperatingSystem | 
    Select-Object CSName, LastBootUpTime

```
### Open explorer from powershell
`explorer .`

### Set-ExecutionPolicy RemoteSigned
`unblock-file c:\pathname\filename.ps1`

### powershell profiles
#### display powershell profiles
`$profile | select *host* | format-list`
#### see if a profile exists
`dir $profile`

### create profile if does not exist
`new-item $profile -force`

`add-content -Value 'cd c:\scripts' -Path $profile`

### an example of a basic script
> /automation-powershell-scripts/03/demos/basicscripts.ps1

### update powershell help
`update-help -Verboe -Force -ErrorAction SilentlyContinue`

### if statement
```powershell
if(Test-Path c:\files\data.txt) {
  $data = Get-Content c:\files\data.txt
}
elseif{
  Write-Warning "some other message"
}
else {
  Write-Warning "can't find c:\files.data.txt"
}

```
### ForEach
`2,5,6,7 | ForEach {$_ *3}`

- $_ represent current object in pipeline

$n = 1..10
foreach($item in $n) {
  $file = "TestFile-$item.txt"
  New-Item $file
}

### Arrays
#### Create an empty array and add stuff to it
```powershell
$arr = @()
$arr += 100
$arr -is[array]
```

### Hashtable
`
$hash=@{Name="jeff"}
$hash=@{Name="jeff";Color="green"; Version=$PSVersionTable.PSVersion}
$hash.Add("foo",1)
$hash.color = "red"
`
### Ordered Hashtable

$h = [ordered]@{
  Name='Jeff'
  Color='green'
  Version=$psversiontable.psversion
}

### Splatting
$params = @{
  Computername = 'Server01'
  Classname = 'win32_logicaldisk'
  Filter = "deviceid='c:'"
  Verbose = $True
}
@params
### type accelerator
`dir c:\work -file | 
foreach-object {
  [pscustomobject]@{
    Name = $_.Name
    Size = $_.length
    Modified = $_.LastWriteTime
    Age = (Get-Date)=$_.LastWriteTime
  }
}`

### PowerShell with Dates
#### To get the current date
`Get-Date`

#### To get all the files that fall within a cutoff period
`$cutoff = (Get-Date).AddDays(-180).Date`
`dir \\srv1\public -File | Where {$_.LastWriteTime -lie $cutoff }`

### Math class
- Get all the available math methods
`[math].GetMembers() | Select Name, MemberType -unique | sort MemberType, Name | more`

#### Invoking Static Members
`[math]::PI`

#### Function to truncate decimal points
```powershell
$n = 1234.5678
[math]::Truncate($n)
```
`[math]::pow.OverloadDefinitions`

`Get-CimInstance win32_operatingsystem | Select *memory*`

### Powershell popup window
$wsh = new-object -com wscript.shell
$wsh.Popup("Isnt this fun?",10,"PowerShell Automation",0+64)

### Powershell set parameter values
`$PSDefaultParameterValues.Add("get-eventlog:logname","system")`
`$PSDefaultParameterValues.Clear()`






