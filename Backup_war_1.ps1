function Backup-WarFiles {
    param (
        [string]$SourceFolder,
        [string]$DestinationFolder
    )

    try {
        # Get war files in the source folder
        $warFiles = Get-ChildItem -Path $SourceFolder -Filter "*.jar" -File

        # Check if war files exist
        if ($warFiles.Count -eq 0) {
            Write-Host "Jar files do not exist in the source folder: $SourceFolder"
            return
        }

        # Get current timestamp
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

        # Loop through each war file and copy it to the destination folder with timestamp
        foreach ($file in $warFiles) {
            $timestampedFileName = "{0}_{1}{2}" -f $file.BaseName, $timestamp, $file.Extension
            $destinationFilePath = Join-Path -Path $DestinationFolder -ChildPath $timestampedFileName
            Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            Write-Host "Backed up $($file.FullName) to $($destinationFilePath)"

            # Delete the war file from the source folder
            Remove-Item -Path $file.FullName -Force
            Write-Host "Deleted $($file.FullName)"
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define source and destination folder paths
$sourceFolder = "D:\webpay"
$destinationFolder = "C:\example"

# Call the function to backup war files with timestamp and delete them from the source folder
Backup-WarFiles -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
