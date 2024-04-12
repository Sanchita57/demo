function Rollback-Backup {
    param (
        [string[]]$BackupFolders,
        [string[]]$SourceFolders
    )

    try {
        # Loop through each pair of backup and source folders
        for ($i = 0; $i -lt $BackupFolders.Count; $i++) {
            $BackupFolder = $BackupFolders[$i]
            $SourceFolder = $SourceFolders[$i]

            # Get the latest backup folder
            $latestBackupFolder = Get-ChildItem -Path $BackupFolder | Sort-Object LastWriteTime -Descending | Select-Object -First 1

            # Check if there is any backup folder
            if (-not $latestBackupFolder) {
                Write-Host "No backup folders found in: $BackupFolder"
                continue
            }

            # Get the list of files in the latest backup folder
            $backupFiles = Get-ChildItem -Path $latestBackupFolder.FullName

            # Check if there are files to restore
            if ($backupFiles.Count -eq 0) {
                Write-Host "No files found in the backup folder: $($latestBackupFolder.FullName)"
                continue
            }

            # Output files inside the backup folder one by one
            Write-Host "Files inside the $latestBackupFolder are:"
            foreach ($file in $backupFiles) {
                Write-Host "- $($file.Name)"
            }

            # Restore files from backup folder to source folder

            # Copy files from backup folder to source folder
            Copy-Item -Path "$($latestBackupFolder.FullName)\*" -Destination $SourceFolder -Recurse -Force

            Write-Host "Files copied back to $($SourceFolder)"

            # Remove the backup folder after files have been restored
            Remove-Item -Path $latestBackupFolder.FullName -Recurse -Force

            Write-Host "Backup folder removed for $($SourceFolder)"
            Write-Host "Rollback for $($SourceFolder) completed successfully."
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define backup and source folder paths
$BackupFolders = @("C:\example1\Backup1", "C:\example2\Backup2")
$SourceFolders = @("C:\example1", "C:\example2")

# Call the function to rollback the backup for each pair of folders
Rollback-Backup -BackupFolders $BackupFolders -SourceFolders $SourceFolders
