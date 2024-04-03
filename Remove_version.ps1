# Specify the folder containing the files
$folderPath = "D:\webpay\maven"

# Get all files in the folder
$files = Get-ChildItem -Path $folderPath

# Loop through each file
foreach ($file in $files) {
    # Get the file name without extension
    $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
    
    # Use a regular expression to remove version numbers from the file name
    $fileNameWithoutVersion = $fileNameWithoutExtension -replace '_\d+(\.\d+)*', ''
    
    # Get the file extension
    $extension = $file.Extension
    
    # Construct the new file name
    $newFileName = $fileNameWithoutVersion + $extension
    
    # Rename the file
    Rename-Item -Path $file.FullName -NewName $newFileName -Force
}
