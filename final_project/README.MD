# Hard Drive Checker Documentation:

- This is the Final Project script that will check external hard drives for storage information. 

- It is designed to be simple to use, yet provide important storage information such as total storage, availability, and more. 

- If the selected drive has less than 50% available storage, then a warning message will be displayed and the largest file name and size will be shown. 

- #### Note: This script is designed for checking external hard drives. If you decide to check the local (C:) drive, then the script will run, but the results will be limited to the storage information and will not show the largest file if storage space is low. 

- #### This is due to the issue of the information the script retrieves from the local (C:) drive compared to external drives.

---

## Table of Contents:

- [Installation](#installation)
- [Usage](#usage)

---

## Installation:

- To run this script, you will need to do the following:

  1. Download the script [here](./final_project.ps1) and save it to a memorable location on your computer.

  2. Choose an IDE that supports PowerShell (.ps1) files.
    - Make sure to run the IDE as an Administrator 

  3. Set the Execution-Policy on your system to allow the script to run.

    - Use the following command in a terminal on your chose IDE to allow the execution of scripts for the current terminal session:

      ```powershell
        Set-ExecutionPolicy Unrestricted -Scope Process
        ```

      - Select "Yes to All" button in the prompt.

  4. Open the [final_project.ps1](./final_project.ps1) in the selected IDE. In the warnign prompt, select "Run Once" to run the script.

---

## Usage:

- This script is designed to provide key information on external hard drives by entering the drive leter you want to check.

- The script will return the volume name, total storage, free space, available storage, used storage, and the percentage of used and available storage.

- If the storage has less than 50% available storage, the script will print the largest file name and size.

- If you decide to enter another letter, you will be asked to do so at the end of the script.


