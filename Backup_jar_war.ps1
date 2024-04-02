function Backup-XMLAndJARFiles {
    param (
        [string]$SourceFolder,
        [string]$DestinationFolder
    )

    try {
        # Get XML files in the source folder
        $warFiles = Get-ChildItem -Path $SourceFolder -Filter "*.war" -File

         if ($warFiles.Count -eq 0) {
            Write-Host "war files do not exist in the source folder: $SourceFolder"
            return
        }


        # Get JAR files in the source folder
        $jarFiles = Get-ChildItem -Path $SourceFolder -Filter "*.jar" -File

        # Combine XML and JAR files into a single array
        $xmlAndJarFiles = @($xmlFiles) + @($jarFiles)

        # Check if XML and JAR files exist
        if ($null -eq $xmlAndJarFiles) {
            Write-Host "XML and JAR files do not exist in the source folder: $SourceFolder"
            return
        }

        # Get current timestamp
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

        # Loop through each XML and JAR file and copy it to the destination folder with timestamp
        foreach ($file in $xmlAndJarFiles) {
            $timestampedFileName = "{0}_{1}{2}" -f $file.BaseName, $timestamp, $file.Extension
            $destinationFilePath = Join-Path -Path $DestinationFolder -ChildPath $timestampedFileName
            Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            Write-Host "Backed up $($file.FullName) to $($destinationFilePath)"

            # Delete the XML and JAR file from the source folder
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

# Call the function to backup XML and JAR files with timestamp and delete them from the source folder
Backup-XMLAndJARFiles -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
