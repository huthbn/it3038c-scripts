# Display welcome message

Write-Host ""

Write-Output "Welcome! This script is designed to give users storage information on their external hard drives."

Write-Host ""

Start-Sleep -Seconds 2

Write-Output "At the end, you will be given the opportunity to check another hard drive."

do {

    Start-Sleep -Seconds 3

    # Reset value of $largestDrive variable back to null

    $largestFile = $null

    Write-Host ""

    # Prompt user to enter hard drive letter 

    do {

        $driveletter = Read-Host -Prompt "Please enter the letter of the hard drive you want to look at (make sure to include a colon)"

        # Check if entered drive letter exists.

        do {

            $testDriveLetter = Test-Path "$driveletter\"

            if (-not ($testDriveLetter)) {

                Start-Sleep -Seconds 1

                Write-Host ""

                Write-Host "Error: Drive $driveletter not found on computer."

                Write-Host ""

                Start-Sleep -Seconds 2

                Write-Output "If you have entered the correct drive letter, make sure the letter is capitalized with a colon placed after the drive letter."

                Write-Host ""

                Start-Sleep -Seconds 2

                $driveletter = $null

                $driveletter = Read-Host -Prompt "Please enter the letter of the hard drive you want to look at (make sure to include a colon)"

            }

        }

        while (-not $testDriveLetter)

        # Display warning message if user enters C: drive into the prompt 

        if ($driveletter -eq 'C:') {

            Write-Host ""

            Start-Sleep -Seconds 3

            Write-Output "Note: You have entered the C: drive. This script is designed for external hard drives."

            Start-Sleep -Seconds 2

            Write-Host ""

            Write-Output "This script will display the correct storage information for the C: drive, but the largest file size and other information may not be accurate."

            Write-Host ""

            Start-Sleep -Seconds 3

            Write-Output "It is best to select an external hard drive for the full functionality and accuracy of the script."

            Start-Sleep -Seconds 4

            Write-Host ""

        }

    # Check to make sure user entered the drive letter in the correct format. Display error message if no colon was inserted.

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

    Write-Host ""

    Write-Host ""

    # Display volume name

    $volumeName = $disk.VolumeName

    Start-Sleep -Seconds 3

    Write-Output "The volume name is $volumeName"

    Start-Sleep -Seconds 3

    # If the capacity/availability of storage is less than 1GB, calculate and display the data in MB.

    if ($disk.Size -lt 1GB -or $disk.FreeSpace -lt 1GB) {

        $totalStorageMB = [math]::Round($disk.Size / 1MB)   

        $availableStorageMB = [math]::Round($($disk.FreeSpace / 1MB))

        Write-Host ""

        Write-Host "The $driveletter drive has about $totalStorageMB MB of total storage with $availableStorageMB MB available."

        Start-Sleep -Seconds 3

        # Display how much storage is used, how much is available, and display these in MB and percentages

        $usedStorageMB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1MB)

        $usedPercentageMB = [math]::Round(($usedStorageMB / $totalStorageMB)* 100)

        $availablePercentageMB = 100 - $usedPercentageMB

        Write-Host ""

        Write-Output "The $driveletter drive has about $usedStorageMB MB of storage used."

        Write-Output ""

        Start-Sleep -Seconds 3

        Write-Output "$driveletter is at $usedPercentageMB% capacity with $availablePercentageMB% remaining."

        Write-Host ""

        # If the C: drive is selected, skip this section of the script

        if (($driveletter -ne "C:") -or ($driveletter -ne "C")) {

        # Display message based on available storage

        if ($availablePercentageMB -ge 50) {

            Write-Output "You have plenty of storage left!"

        }
    
        elseif (($availablePercentageMB -gt 25) -and ($availablePercentageMB -lt 50)) {

            Write-Output "You still have some space left. This is the largest file in the $driveletter drive:"

            Start-Sleep -Seconds 2

            Write-Host ""

            # Get the largest file in the entire drive

            $largestFile = Get-ChildItem -Path "$driveletter\*" -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

            # Check if the selected drive contains files

                if ($largestFile) {

                    Write-Output "Name: $($largestFile.Name)"
    
                    Write-Host ""
    
                    Start-Sleep -Seconds 3

                    # Add error handling for displaying bytes, MBs, or greater

                    if ($largestFile.Length -lt 1MB) {

                        Write-Output "Size: $([math]::Round($largestFile.Length / 1KB)) KB"

                    }

                    elseif (($largestFile.Length -ge 1MB) -and ($largestFile.Length -lt 1GB)) {

                        Write-Output "Size: $([math]::Round($largestFile.Length / 1MB)) MB"
                    }

                    else {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1GB)) GB"

                    }

                } 

                else {

                    Write-Output "No files found on the $driveletter drive."

                }

        }

        # If available storage is less than 25%, display warning message and list the largest file in the drive

        else {

            Write-Output "You are running low on space in the $driveletter drive. This is the largest file in the $driveletter drive:"

            $largestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

            Write-Host ""

            Start-Sleep -Seconds 3

            # Check if the selected drive contains files

            if ($largestFile) {

                Start-Sleep -Seconds 2

                Write-Output "Name: $($largestFile.Name)"

                # Calculate and display storage size in KB, MB, or GB

                if ($largestFile.Length -lt 1MB) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1KB)) KB"

                }
    
                elseif (($largestFile.Length -ge 1MB) -and ( $largestFile.Length -lt 1GB)) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1MB)) MB"

                }

                else {
        
                    Write-Output "Size: $([math]::Round($largestFile.Length / 1GB)) GB"

                }

            } 


            else {

                Write-Output "No files found on the $driveletter drive."

            }

        }

    }

}

    # If the capacity or availability of selected drive is more than 1GB, then calculate and display information in GB

    else {

        $totalStorageGB =  [math]::Round($disk.Size /1GB)

        $availableStorageGB = [math]::Round($disk.FreeSpace / 1GB)

        Write-Host ""

        Write-Host "The $driveletter drive has about $totalStorageGB GB of total storage with $availableStorageGB GB available."

        Start-Sleep -Seconds 3

        # Display how much storage is available and the total amount of storage used.

        $usedStorageGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB)

        $usedPercentageGB = [math]::Round(($usedStorageGB / $totalStorageGB)* 100)

        $availablePercentageGB = 100 - $usedPercentageGB

        Write-Host ""

        Write-Output "The $driveletter drive has about $usedStorageGB GB of storage used."

        Write-Host ""

        Start-Sleep -Seconds 3

        Write-Host "$driveletter is at $usedPercentageGB% capacity with $availablePercentageGB% remaining."

        Write-Host ""

        # If C: drive is selected, skip this section of the script.

        if (($driveletter -notlike "C:") -and ($driveletter -notlike "C")) {

        # Display message based on available storage

        if ( $availablePercentageGB -gt 50 ) {

            Write-Output "You have plenty of storage left!"

            Write-Host ""

            Start-Sleep -Seconds 3

        }

        # If the storage is between 25%-50%, display warning message and display the largest file name and size

        elseif (($availablePercentageGB -gt 25) -and ($availablePercentageGB -le 50)) {

            Write-Output "You still have some space left. This is the largest file in the $driveletter drive"

            Start-Sleep -Seconds 2

            Write-Host ""
        
            # Get the largest file in the entire drive

            $largestFile = Get-ChildItem -Path "$driveletter\*" -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1 -Property Name, Length

            # Check if the selected drive contains files

            if ($largestFile) {

                Write-Output "Name: $($largestFile.Name)"
    
                Write-Host ""
    
                Start-Sleep -Seconds 3

                # Add error handling for displaying bytes, MBs, or greater

                if ($largestFile.Length -lt 1MB) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1KB)) KB"
               
                }

                elseif (($largestFile.Length -ge 1MB) -and ($largestFile.Length -lt 1GB)) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1MB)) MB"
                }

                else {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1GB)) GB"

                }

            } 

            else {

                Write-Output "No files found on the $driveletter drive."

            }

        }

        # If the storage is less than 25%, display warning message and list the largest file in the drive.

        else {

            Write-Output "You are running low on space. This is the largest file in the $driveletter drive:"

            Write-Host ""

            Start-Sleep -Seconds 3

            # Check if the selected drive contains files

            if ($largestFile) {

                Start-Sleep -Seconds 2

                Write-Output "Name: $($largestFile.Name)"

                Write-Host ""

                Start-Sleep -Seconds 3

            # Calculate and display storage size in KB, MB, or GB

                if ($largestFile.Length -lt 1MB) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1KB)) KB"

                }
    
                elseif (($largestFile.Length -ge 1MB) -and ($largestFile.Length -lt 1GB)) {

                    Write-Output "Size: $([math]::Round($largestFile.Length / 1MB)) MB"

                }

                else {
        
                    Write-Output "Size: $([math]::Round($largestFile.Length / 1GB)) GB"

                }

            } 

            else {

                Write-Output "No files found on the $driveletter drive."

            }

        }

    }

    }

    Write-Host ""

    Start-Sleep -Seconds 3

    # Prompt user to enter another hard drive or exit the script

    $checkAnotherDrive = Read-Host -Prompt "Would you like to check another hard drive? (Enter yes/no)" 

}

while ($checkAnotherDrive -eq 'yes')

Write-Host ""

Start-Sleep -Seconds 2

Write-Output "Hope you've found the information valuable!"

Write-Host ""