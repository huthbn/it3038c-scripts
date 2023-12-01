# Hard Drive Checker Documentation

This is the Final Project script that will check external hard drives for storage information. 

It is designed to be simple to use, yet provide important storage information such as total storage, availability, and more. 

If the selected drive has less than 50% available storage, then a warning message will be displayed and the largest file name and size will be shown. 

#### Note: This script is designed for checking external hard drives. If you decide to check the local (C:) drive, then the script will run, but the results will be limited to the storage information and will not show the largest file if storage space is low. 

#### This is due to the issue of the script retreiving information from the local drive instead of external drives.

## Table of Contents

- [Installation](#instlalation)
- [Usage](#usage)

## Installation

To run this script, you will need to download it [here](./project3.py). I prefer to use Powershell ISE to run the script, but any IDE compatible with .ps1 files will work.

After downloading and opening the script in a supported IDE, click "Run" to run it.

No other installation is requred.

## Usage

This script is designed to provide key information on external hard drives by entering the drive leter you want to check.

The script will return the volume name, total storage, free space, available storage, used storage, and the percentage used and available storage.

If the storage has less than 50% available storage, the script will print the largest file name and size.

If you decide to enter another letter, you will be asked to do so at the end of the script.


