# Define source and destination paths
#$sourcePath = "D:\webpay\"
#$destinationPath = "C:\example"

#Copy files from source to destination
#Copy-Item -Path $sourcePath\* -Destination $destinationPath -Force

#Write-Host "Files in destination directory:"
#Get-ChildItem -Path $destinationPath

<#--->function Copy-Files {
    param (
        [string]$SourcePath,
        [string]$DestinationPath
    )

    try {
        # Check if files exist in the destination directory
        if (Test-Path -Path $DestinationPath\*) {
            Write-Host "Files already exist in the destination directory. No action required."
        } else {
            # Copy files from source to destination
            Copy-Item -Path $SourcePath\* -Destination $DestinationPath -Recurse -Force

            # Print files in the destination directory
            Write-Host "Files copied successfully. Files in destination directory:"
            Get-ChildItem -Path $DestinationPath -Recurse
        }
    }
    catch {
        Write-Host "Error occurred while copying files: $_"
    }
}

# Define source and destination paths
$sourcePath = "D:\webpay\"
$destinationPath = "C:\example"

# Call the function to copy files
Copy-Files -SourcePath $sourcePath -DestinationPath $destinationPath

#below is the another script

function Copy-Files {
    param (
        [string]$SourcePath,
        [string]$DestinationPath
    )

    try {
        # Check if files exist in the destination directory
        if (Test-Path -Path $DestinationPath\*) {
            Write-Host "Files already exist in the destination directory. No action required."
        } else {
            # Copy files and folders from source to destination
            Copy-Item -Path "$SourcePath\*" -Destination $DestinationPath -Recurse -Force

            # Print files and folders in the destination directory
            Write-Host "Files and folders copied successfully. Items in destination directory:"
            Get-ChildItem -Path $DestinationPath -Recurse
        }
    }
    catch {
        Write-Host "Error occurred while copying files and folders: $_"
    }
}

# Define source and destination paths
$SourcePath = "D:\webpay\"
$DestinationPath = "C:\example\"

# Call the function to copy files and folders
Copy-Files -SourcePath $SourcePath -DestinationPath $DestinationPath



Perfect script for copy even folders

# Define source and destination paths
$webpayFolderPath = "D:\webpay"
$destinationFolderPath = "C:\example"

# Copy folders starting with "digi" inside the "webpay" folder
Get-ChildItem -Path "$webpayFolderPath\digi*" -Directory | ForEach-Object {
    $sourceFolderPath = $_.FullName
    $destinationFolderName = $_.Name
    Copy-Item -Path $sourceFolderPath -Destination "$destinationFolderPath\$destinationFolderName" -Recurse -Force
}

# Copy files from the "webpay" folder
Copy-Item -Path "$webpayFolderPath\*" -Destination $destinationFolderPath -Recurse -Force
#>

<#
# Define the source and destination paths
$sourceFolderPath = "D:\webpay"
$destinationFolderPath = "C:\example"

# Copy the folder and all its contents from the source to the destination
Copy-Item -Path $sourceFolderPath -Destination $destinationFolderPath -Recurse -Force


BELOW SCRIPT WORKS FINE FOR COPYING WHOLE FOLDER


function Copy-FolderContents {
    param (
        [string]$SourceFolderPath,
        [string]$DestinationFolderPath
    )

    try {
        # Check if source folder exists
        if (!(Test-Path -Path $SourceFolderPath -PathType Container)) {
            throw "Source folder '$SourceFolderPath' does not exist."
        }

        # Copy the folder and all its contents from the source to the destination
        Copy-Item -Path $SourceFolderPath -Destination $DestinationFolderPath -Recurse -Force
        Write-Host "Folder and its contents copied successfully from '$SourceFolderPath' to '$DestinationFolderPath'."
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define source and destination paths
$sourceFolderPath = "D:\webpay"
$destinationFolderPath = "C:\example"

# Call the function to copy the folder and its contents
Copy-FolderContents -SourceFolderPath $sourceFolderPath -DestinationFolderPath $destinationFolderPath
#>
function Copy-FolderContentsWithTimestamp {
    param (
        [string]$SourceFolderPath,
        [string]$DestinationParentPath,
        [string]$DestinationDrive

    )

    try {
        # Check if source folder exists
        if (!(Test-Path -Path $SourceFolderPath -PathType Container)) {
            throw "Source folder '$SourceFolderPath' does not exist."
        }

        $sourceFolderName = (Get-Item $SourceFolderPath).Name

        # Generate a timestamp for the destination folder name
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

        $destinationFolderName = "${sourceFolderName}_${timestamp}"

        #$destinationFolderPath = Join-Path -Path $DestinationParentPath -ChildPath ("destination_folder_$timestamp")
        $destinationFolderPath = Join-Path -Path $DestinationParentPath -ChildPath $destinationFolderName

        # Print the content of the source folder
        Write-Host "Content of the source folder '$SourceFolderPath':"
        Get-ChildItem -Path $SourceFolderPath
        Start-Sleep -Seconds 3
        Write-Host ""
        Write-Host "Copying..."
        Write-Host ""
        Start-Sleep -Seconds 3

        # Copy the folder and all its contents from the source to the destination
        Copy-Item -Path $SourceFolderPath -Destination $destinationFolderPath -Recurse -Force
        Write-Host "Folder and its contents copied successfully from '$SourceFolderPath' to '$destinationFolderPath'."
        # Copy the folder from the destination path to another drive
        Start-Sleep -Seconds 3

        Write-Host ""
        $destinationDrivePath = Join-Path -Path $DestinationDrive -ChildPath $destinationFolderName
        Copy-Item -Path $destinationFolderPath -Destination $destinationDrivePath -Recurse -Force
        Write-Host "Folder and its contents copied successfully from '$destinationFolderPath' to '$destinationDrivePath'."
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define source folder path
$sourceFolderPath = "D:\webpay\digii"

# Define parent path for the destination folder
$destinationParentPath = "C:\example"
$destinationDrive = "D:\"

# Call the function to copy the folder and its contents with timestamp
Copy-FolderContentsWithTimestamp -SourceFolderPath $sourceFolderPath -DestinationParentPath $destinationParentPath -DestinationDrive $destinationDrive

