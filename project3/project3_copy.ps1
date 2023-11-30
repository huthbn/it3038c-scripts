# Display welcome message

Write-Host ""

Write-Output "This script will display information about your selected hard drive."

Write-Host ""

Start-Sleep -Seconds 2

Write-Output "At the end, you will be given the opportunity to check another hard drive."

# Add delay and space before the next prompt

Start-Sleep -Seconds 3

Write-Host ""

# Prompt user to enter hard drive letter 

$driveletter = Read-Host -Prompt "Please enter the hard drive letter you want to look at (make sure to include a colon)"

# Check to make sure user entered the drive letter in the correctn format. Throw error if not

$largestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

Write-Output $largestFile
