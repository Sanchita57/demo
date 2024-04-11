function Rollback-Backup {
    param (
        [string]$BackupFolder,
        [string]$SourceFolder
    )

    try {
        $latestBackupFolder = Get-ChildItem -Path $BackupFolder | Sort-Object LastWriteTime -Descending | Select-Object -First 1

        if (-not $latestBackupFolder) {
            Write-Host "No backup folders found in: $BackupFolder"
            return
        }

        # Get the list of files in the latest backup folder
        $backupFiles = Get-ChildItem -Path $latestBackupFolder.FullName

        
        # Check if there are files to restore
        if ($backupFiles.Count -eq 0) {
            Write-Host "No files found in the backup folder: $($latestBackupFolder.FullName)"
            return
        }

        Write-Host "Files inside the $latestBackupFolder are:"
        foreach ($file in $backupFiles) {
            Write-Host "- $($file.Name)"
        }

        Write-Host ""
        Start-Sleep -Seconds 3


        # Loop through each file in the backup folder and restore it to the source folder
        foreach ($file in $backupFiles) {
            $destinationFilePath = Join-Path -Path $SourceFolder -ChildPath $file.Name
            Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            Write-Host "Restored $($file.FullName) to $($destinationFilePath)"
            Remove-Item -Path $file.FullName -Force
            Write-Host "Deleted $($file.FullName)"
            Write-Host ""
        }
        Remove-Item -Path $latestBackupFolder.FullName -Force
        Write-Host "Removed backup folder: $($latestBackupFolder.FullName)"
        Write-Host ""

        Write-Host "Rollback completed successfully."
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define backup and source folder paths
$BackupFolder = "C:\example\Backup"
$SourceFolder = "C:\example"

# Call the function to rollback the backup
Rollback-Backup -BackupFolder $BackupFolder -SourceFolder $SourceFolder
