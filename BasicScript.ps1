$computername = $env:COMPUTERNAME
$data = Get-EventLog System -EntryType Error -Newest 1000 -ComputerName $computername |
Group -Property Source -NoElement

#create an HTML report
$title = "System Log Analysis"
$footer = "<h5>report run $(Get-Date)</h5>"
$css = "http://jdhitsolutions.com/sample.css"

$data | Sort -Property Count,Name -Descending |
Select Count,Name | 
ConvertTo-Html -Title $Title -PreContent "<H1>$Computername</H1>" -PostContent $footer -CssUri $css |
Out-File c:\dev\work\systemsources.html

Invoke-Item C:\dev\work\systemsources.html