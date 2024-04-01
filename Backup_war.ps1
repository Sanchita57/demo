function Backup-WarFiles {
    param (
        [string]$SourceFolder,
        [string]$DestinationFolder
    )

    try {
        # Get current timestamp
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

        # Get war files in the source folder
        $warFiles = Get-ChildItem -Path $SourceFolder -Filter "*.war" -File

        # Loop through each war file and copy it to the destination folder with timestamp
        foreach ($file in $warFiles) {
            $timestampedFileName = "{0}_{1}{2}" -f $file.BaseName, $timestamp, $file.Extension
            $destinationFilePath = Join-Path -Path $DestinationFolder -ChildPath $timestampedFileName
            Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            Write-Host "Backed up $($file.FullName) to $($destinationFilePath)"
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
