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

# Check to make sure the user entered a colon with the error handling and display error message if conditions are met.

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

# If the capacity/availability of storage is less than 1GB, calculate and display the data in MB.

$usedStorageInMB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1MB)

$usedPercentageInMB = [math]::Round(($usedStorageMB / $total_storage)* 100)

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageInMB MB of total storage."

Write-Host ""

# If the capacity is more than 1GB, then calculate and display information in GB

$usedStorageInGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

$usedPercentageInGB = [math]::Round(($usedStorageInGB / $total_storage)* 100)

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageInGB GB of total storage."

# Display message based on the amout of data capacity or availability.

$used_storage = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

$used_percentage = [math]::Round(($used_storage / $total_storage)* 100)

#Calculate the available storage

$available_percent = 100 - $used_percentage

#Shows the percentage of used and available storage.

Start-Sleep -Seconds 2

Write-Host ""

Write-Host "$used_percentage% has been used and $available_percent% remains."

# If the storage is above 50%, say "You have plenty of space left!"

# If the storage is between 25%-50%, say "You still have some space left" and show the top three files that are taking up the most space. 

# If the storage is less than 25%, say "You are running low on space!" and display the top files with the most storage.

Start-Sleep -Seconds 3

Write-Host ""

Write-Host "Hope you've found the information valuable!"