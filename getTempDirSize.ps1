Get-ChildItem $env:temp -file -Recurse | Measure-Object Length -sum |
Select-Object Count,@{Name="SumMB"; Expression = {[math]::round($_.sum/1mb,3)}
}
