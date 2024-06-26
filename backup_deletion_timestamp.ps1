#backup script
function Backup-XMLAndJARFiles {
    param (
        [string]$SourceFolder,
        [string]$DestinationFolder
    )

    try {
        # Get XML files in the source folder
        $xmlFiles = Get-ChildItem -Path $SourceFolder -Filter "*.xml" -File

        # Get JAR files in the source folder
        $jarFiles = Get-ChildItem -Path $SourceFolder -Filter "*.jar" -File

        # Check if XML files exist
        if ($xmlFiles.Count -eq 0) {
            Write-Host "XML files do not exist in the source folder: $SourceFolder"
        }

        # Check if JAR files exist
        if ($jarFiles.Count -eq 0) {
            Write-Host "JAR files do not exist in the source folder: $SourceFolder"
        }

        # Combine XML and JAR files into a single array
        $filesToBackup = @($xmlFiles) + @($jarFiles)

        # Check if there are files to backup
        if ($filesToBackup.Count -eq 0) {
            Write-Host "No XML or JAR files to backup in the source folder: $SourceFolder"
            return
        }

        # Get current timestamp
        $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

        # Define folder name with timestamp and "emvco"
        $folderName = "emvco_$timestamp"

        # Create folder with timestamp inside the destination folder
        $timestampedFolder = Join-Path -Path $DestinationFolder -ChildPath $folderName
        New-Item -Path $timestampedFolder -ItemType Directory -Force

        # Loop through each file and copy it to the destination folder without timestamp
        foreach ($file in $filesToBackup) {
            $destinationFilePath = Join-Path -Path $timestampedFolder -ChildPath $file.Name
            Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            Write-Host "Backed up $($file.FullName) to $($destinationFilePath)"

            # Delete the XML and JAR file from the source folder
            Remove-Item -Path $file.FullName -Force
            Write-Host "Deleted $($file.FullName)"
        }

        Write-Host "All files backed up to folder $($timestampedFolder)"

        # Delete old backup folders, leaving the most recent 5 folders
        $oldBackupFolders = Get-ChildItem -Path $DestinationFolder | Where-Object { $_.PSIsContainer } | Sort-Object CreationTime -Descending | Select-Object -Skip 5
        if ($oldBackupFolders) {
            $oldBackupFolders | ForEach-Object {
                Write-Host "Deleting old backup folder: $($_.FullName)"
                Remove-Item -Path $_.FullName -Recurse -Force
            }
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define source and destination folder paths
$sourceFolder = "C:\example1"
$destinationFolder = "C:\example1\Backup1"

# Call the function to backup XML and JAR files without timestamp and create a folder with timestamp
Backup-XMLAndJARFiles -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
