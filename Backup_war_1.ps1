function Backup-WarFiles {
    param (
        [string]$SourceFolder,
        [string]$DestinationFolder
    )

    try {
        # Get war files in the source folder
        $warFiles = Get-ChildItem -Path $SourceFolder -Filter "*.war" -File

        # Loop through each war file and copy it to the destination folder with timestamp
        foreach ($file in $warFiles) {
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $timestampedFileName = "{0}_{1}{2}" -f $file.BaseName, $timestamp, $file.Extension
            $destinationFilePath = Join-Path -Path $DestinationFolder -ChildPath $timestampedFileName
            
            # Check if the file already exists in the destination folder
            if (-not (Test-Path -Path $destinationFilePath)) {
                # File does not exist, copy it to the destination folder
                Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
                Write-Host "Backed up $($file.FullName) to $($destinationFilePath)"
            } else {
                Write-Host "File $($file.Name) with timestamp $($timestamp) already exists in $($DestinationFolder)"
            }
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Define source and destination folder paths
$sourceFolder = "D:\webpay"
$destinationFolder = "C:\example"

# Call the function to backup war files with timestamp
Backup-WarFiles -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
