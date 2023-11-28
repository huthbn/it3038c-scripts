#Add space before first prompt

Write-Host ""

Write-Output "This script will display information about your selected hard drive."

Write-Host ""

#Add delay before second promt

Start-Sleep -Seconds 1

Write-Output "At the end, you will be given the opportunity to check another hard drive."

# Add delay before the next message and prompt

Start-Sleep -Seconds 3

# Add space between prompts
Write-Host ""

#Declare read-host variable for the user to select input

do {
$driveletter = Read-Host -Prompt "Please enter the hard drive letter you want to look at (make sure to include a colon)"

# Check to make sure the user entered a colon with the error handling and display error message if conditions are met.
if ($driveletter -notlike '*:*') {
    Write-Host "Error: Please include a colon at the end of the drive letter."
    }
} while ($driveletter -notlike '*:*')
#Proceed to the next prompt if the colon is used

#Display all storage information based on selected drive

$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$driveletter'"

Write-Output $disk


