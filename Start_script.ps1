# Set the path to the configuration file
$configPath = "D:\webpay\services_config.txt"


$services = Get-Content -Path $configPath -ErrorAction Stop | ForEach-Object { $_ -split ',' | ForEach-Object { $_.Trim() } }

Write-Host "Services listed in the file to start:"
$services

Start-Sleep -Seconds 3

# Start each service
foreach ($service in $services) {
   
    if (-not [string]::IsNullOrWhiteSpace($service)) {
        if ((Get-Service -Name $service -ErrorAction SilentlyContinue).Status -ne "Running") {
            Start-Service -Name $service -ErrorAction Stop
            Write-Host "Started service: $service"
        } else {
            Write-Host "Service $service is already running."
        }
    }
}
Start-Sleep -Seconds 3

Write-Host ""

Write-Host "Status of services after script execution:"
Write-Host ""
foreach ($service in $services) {
    # Skip empty or whitespace-only service names
    if (-not [string]::IsNullOrWhiteSpace($service)) {
        $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Status
        if ($null -ne $serviceStatus) {
            Write-Host "Service: $service, Status: $serviceStatus"
        } else {
            Write-Host "Failed to get status for service: $service."
        }
    }
}


