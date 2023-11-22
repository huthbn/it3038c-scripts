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

$driveletter = Read-Host -Prompt "Please enter the hard drive letter you want to look at (make sure to include a colon)"

# Check to make sure the user entered a colon with the error handling and display error message of conditions are met.

#Proceed to the next prompt if the colon is used

#Display all storage information based on selected drive

$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$driveletter'"

# Declare total storage variables in GB or MB

$totalStorageInGB =  [math]::Round($disk.Size /1GB)
$totalStorageInMB = [math]::Round($disk.Size /1MB)   

#Declare available storage variables in GB or MB

$availableStorageInGB = [math]::Round($($disk.FreeSpace / 1GB))
$availableStorageInMB = [math]::Round($($disk.FreeSpace / 1MB))

#Display information about the selected hard drive

Write-Host ""

Write-Host "Here is some information about the ${driveletter} drive:"

#Add a delay before showing the first result

Start-Sleep -Seconds 3

# Check how the information should be displayed in either GB or MB based on the storage capacity/availability of the selected drive.

# If the capacity/availability of storage is less than 1GB, display the data in MB.

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageInMB MB of total storage."

# If not, then display the storage information in GB.

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageInGB GB of total storage."

#Delay the time before the next result

Start-Sleep -Seconds 3

#Display the contents of the selected drive

Write-Host ""

Write-Host "The $driveletter drive has about $availableStorageInGB GB left."

#Calculate the percentage used of the disk

$used_storage = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

$used_percentage = [math]::Round(($used_storage / $total_storage)* 100)

#Calculate the available storage

$available_percent = 100 - $used_percentage

#Shows the percentage of used and available storage

Start-Sleep -Seconds 2

Write-Host ""

Write-Host "$used_percentage% has been used and $available_percent% remains."

Start-Sleep -Seconds 3

Write-Host ""

Write-Host "Hope you've found the information valuable!"