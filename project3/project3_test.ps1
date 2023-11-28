$largestFile = Get-ChildItem -Path $drivePath -File | Sort-Object Length -Descending | Select-Object -First 1

Write-Output $largestFile