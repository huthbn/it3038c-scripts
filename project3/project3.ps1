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

#Display information about the selected hard drive

Write-Host ""

Write-Host "Here is some information about the ${driveletter} drive:"

#Add a delay before showing the first result

Start-Sleep -Seconds 3

# If the capacity/availability of storage is less than 1GB, calculate and display the data in MB.

$totalStorageMB = [math]::Round($disk.Size / 1MB)   

$availableStorageMB = [math]::Round($($disk.FreeSpace / 1MB))

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageMB MB of total storage. There are $availableStorageMB MB left."

Write-Host ""

# Display storage size, how much is available, and the total amount of storage used.

$usedStorageMB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1MB)

$usedPercentageMB = [math]::Round(($usedStorageMB / $totalStorageMB)* 100)

Write-Output " The $driveletter has about $usedStorageMB MB of storage left. This means that it is at $usedPercentageMB% capacity."

$availablePercentageMB = 100 - $usedPercentageMB

Write-Host "$usedPercentageMB% has been used and $availablePercentageMB% remains."

# If the capacity is more than 1GB, then calculate and display information in GB

$totalStorageGB =  [math]::Round($disk.Size /1GB)

$availableStorageGB = [math]::Round($($disk.FreeSpace / 1GB))

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageGB GB of total storage. There are $availableStorageGB GB left."

Write-Host ""

# Display storage size, how much is available, and the total amount of storage used.

$usedStorageGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

$usedPercentageGB = [math]::Round(($usedStorageGB / $totalStorageGB)* 100)

Write-Output " The $driveletter has about $usedStorageGB GB of storage left. This means that it is at $usedPercentageGB% capacity."

$availablePercentageGB = 100 - $usedPercentageGB

Write-Host "$usedPercentageGB% has been used and $availablePercentageGB% remains."

# If the storage is above 50%, say "You have plenty of space left!"

# If the storage is between 25%-50%, say "You still have some space left" and show the top three files that are taking up the most space. 

# If the storage is less than 25%, say "You are running low on space!" and display the top files with the most storage.

Start-Sleep -Seconds 3

Write-Host ""

Write-Host "Hope you've found the information valuable!"