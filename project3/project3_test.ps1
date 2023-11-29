do {
    $driveletter = Read-Host -Prompt "Please enter the hard drive letter you want to look at (make sure to include a colon)"
    
    # Check to make sure the user entered a colon with the error handling and display an error message if conditions are not met.
    if ($driveletter -notlike '*:*') {
        Write-Host "Error: Please include a colon at the end of the drive letter."
    }
} 

while ($driveletter -notlike '*:*')


# Get the largest file in the specified drive
$secondLargestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -Second 1 -Property Name, Length
$thirdLargestFile = Get-ChildItem -Path $driveletter -File | Sort-Object Length -Descending | Select-Object -Third 1 -Property Name, Length

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

if($secondLargestFile) {

Write-Output "Second Largest File:"
Write-Output "Name: $($SecondlargestFile.Name)"

#Add error handling for displaying bytes, MBs, or greater

if ($secondLargestFile.Length -lt 1MB) {

    Write-Output "$($secondLargestFile.Length / 1KB) KB"
}

elseif ($secondLargestFile.Length -lt 1GB) {

    Write-Output "Size: $($secondLargestFile.Length / 1MB) MB"
}

else {
    Write-Output "Size: $($secondLargestFile.Length / 1GB) GB"
}

} 


else {
Write-Output "No other files found on the $driveletter drive."
}

if($thirdLargestFile) {

    Write-Output "Third Largest File:"
    Write-Output "Name: $($thirdLargestFile.Name)"
    
    #Add error handling for displaying bytes, MBs, or greater
    
    if ($thirdLargestFile.Length -lt 1MB) {
    
        Write-Output "$($thirdLargestFile.Length / 1KB) KB"
    }
    
    elseif ($thirdLargestFile.Length -lt 1GB) {
    
        Write-Output "Size: $($thirdLargestFile.Length / 1MB) MB"
    }
    
    else {
        Write-Output "Size: $($thirdLargestFile.Length / 1GB) GB"
    }
    
    } 
    
    
    else {
    Write-Output "No other files found on the $driveletter drive."
    }
    


