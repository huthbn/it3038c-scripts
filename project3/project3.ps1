# Display welcome message

Write-Host ""

Write-Output "This script will display information about your selected hard drive."

Write-Host ""

Start-Sleep -Seconds 2

Write-Output "At the end, you will be given the opportunity to check another hard drive."

#Add do/while loop to prompt the user to enter another drive

do {

# Add delay and space before the next prompt

Start-Sleep -Seconds 3

Write-Host ""

# Prompt user to enter hard drive letter 

do {

$driveletter = Read-Host -Prompt "Please enter the hard drive letter you want to look at (make sure to include a colon)"

# Check to make sure user entered the drive letter in the correctn format. Throw error if not
if ($driveletter -notlike '*:*') {

    Start-Sleep -Seconds 1

    Write-Host ""

    Write-Host "Error: Please include a colon at the end of the drive letter."

    Write-Host ""

    Start-Sleep -Seconds 2

    }
} 

while ($driveletter -notlike '*:*')

#Display all storage information based on selected drive

$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$driveletter'"

#Display information about the selected hard drive

Write-Host ""

Write-Host "Here is some information about the ${driveletter} drive:"

# Display volume name

$volumeName = $disk.VolumeName

Start-Sleep -Seconds 3

Write-Output "The volume name is $volumeName."

Start-Sleep -Seconds 3

# If the capacity/availability of storage is less than 1GB, calculate and display the data in MB.

if ($disk.Size -lt 1GB -or $disk.FreeSpace -lt 1GB) {

$totalStorageMB = [math]::Round($disk.Size / 1MB)   

$availableStorageMB = [math]::Round($($disk.FreeSpace / 1MB))

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageMB MB of total storage with $availableStorageMB MB available."

Start-Sleep -Seconds 3

# Display storage size, how much is available, and the total amount of storage used.

$usedStorageMB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1MB)

$usedPercentageMB = [math]::Round(($usedStorageMB / $totalStorageMB)* 100)

$availablePercentageMB = 100 - $usedPercentageMB

Write-Host ""

Write-Output " The $driveletter drive has about $usedStorageMB MB of storage used."

Start-Sleep -Seconds 3

Write-Output "$driveletter is at $usedPercentageMB% capacity with $availablePercentageMB% remaining."

}

# Display message based on available storage

if ($availableStorageMB -gt 50) {

Write-Output "You hae plenty of storage left!"

}

elseif (($availableStorageMB -gt 25) -and ($availableStorageMB -lt 50)) {

Write-Output "You still have some space left."

Start-Sleep -Seconds 2

# Calculate and display the biggest file in the selected drive

# Get the largest file in the specified drive
$largestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

# Check if the selected drive contains files
if ($largestFile) {
    Write-Output "Largest File:"
    Write-Output "Name: $($largestFile.Name)"

    #Add error handling for displaying KB, MBs, or greater

    if ($largestFile.Length -lt 1MB) {

        Write-Output "$($largestFile.Length / 1KB) KB"
    }
    
    elseif ($largestFile.Length -lt 1GB) {

        Write-Output "Size: $($largestFile.Length / 1MB) MB"
    }

    else {
        Write-Output "Size: $($largestFile.Length / 1GB) GB"
    }
} 

else {
    Write-Output "No files found on the $driveletter drive."
}

}

else {

Write-Output "You are running low on storage in the $driveletter drive."

# Calculate and display the three biggest files in the selected drive.

$largestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

# Check if the selected drive contains files
if ($largestFile) {
    Write-Output "Largest File:"
    Write-Output "Name: $($largestFile.Name)"

    #Add error handling for displaying bytes, MBs, or greater

    if ($largestFile.Length -lt 1MB) {

        Write-Output "$($largestFile.Length / 1KB) KB"
    }
    
    elseif ($largestFile.Length -lt 1GB) {

        Write-Output "Size: $($largestFile.Length / 1MB) MB"
    }

    else {
        Write-Output "Size: $($largestFile.Length / 1GB) GB"
    }
} 


else {
    Write-Output "No files found on the $driveletter drive."
}

}

# If the capacity is more than 1GB, then calculate and display information in GB

else {

$totalStorageGB =  [math]::Round($disk.Size /1GB)

$availableStorageGB = [math]::Round($($disk.FreeSpace / 1GB))

Write-Host ""

Write-Host "The $driveletter drive has about $totalStorageGB GB of total storage with $availableStorageGB GB available."

Start-Sleep -Seconds 3

# Display how much storage is available and the total amount of storage used.

$usedStorageGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

$usedPercentageGB = [math]::Round(($usedStorageGB / $totalStorageGB)* 100)

$availablePercentageGB = 100 - $usedPercentageGB

Write-Host ""

Write-Output "The $driveletter drive has about $usedStorageGB MB of storage used."

Write-Host ""

Start-Sleep -Seconds 3

Write-Host "$driveletter is at $usedPercentageGB% capacity with $availablePercentageGB% remaining."

Write-Host ""

}

# Display message based on available storage

if ( $availablePercentageGB -gt 50 ) {

Write-Output "You have plenty of storage left!"

}

# If the storage is between 25%-50%, display warning message and show the top file taking the most space

elseif (($availablePercentageGB -gt 25) -and ($availablePercentageGB -le 50)) {

Write-Output "You still have some space left."

Start-Sleep -Seconds 2

$largestFile = Get-ChildItem -Path $drivePath -File | Sort-Object Length -Descending | Select-Object -First 1

}

# If the storage is less than 25%, display warning message and list the top three files with the most storage.

else {
Write-Output "You are running low on space. Here are the top three files in $driveletter drive that are taking up the most storage."

Write-Host ""

# Check if the selected drive contains files
if ($largestFile) {
    Write-Output "Largest File:"

    Write-Host ""

    Start-Sleep -Seconds 2

    Write-Output "Name: $($largestFile.Name)"

    Write-Host ""

    #Add error handling for displaying bytes, MBs, or greater

    if ($largestFile.Length -lt 1MB) {

        Write-Output "$($largestFile.Length / 1KB) KB"
    }
    
    elseif (($largestFile.Length -lt 1GB) -and ($largestFile.Length -gt 1KB)) {

        Write-Output "Size: $($largestFile.Length / 1MB) MB"
    }

    else {
        Write-Output "Size: $($largestFile.Length / 1GB) GB"
    }
} 


else {
    Write-Output "No files found on the $driveletter drive."
}

}

Write-Host ""

Start-Sleep -Seconds 3

# Prompt user to enter another hard drive or exit the script

 $checkAnotherDrive = Read-Host -Prompt "Would you like to check another hard drive? (Enter yes/no)" 

}

while ($checkAnotherDrive -eq 'yes')

Write-Host ""

Start-Sleep -Seconds 1

Write-Output "Hope you've found the information valuable!"