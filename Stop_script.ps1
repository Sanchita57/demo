# Set the path to the configuration file
$configPath = "D:\webpay\services_config.txt"

$services = Get-Content -Path $configPath -ErrorAction Stop | ForEach-Object { $_ -split ',' | ForEach-Object { $_.Trim() } }

Write-Host "Services listed in the file to stop:"
$services

Start-Sleep -Seconds 3

# Stop each service
foreach ($service in $services) {
    
    if (-not [string]::IsNullOrWhiteSpace($service)) {
        
        if ((Get-Service -Name $service -ErrorAction SilentlyContinue).Status -eq "Running") {
            Stop-Service -Name $service -ErrorAction Stop
            Write-Host "Stopped service: $service"
        } else {
            Write-Host "Service $service is already stopped."
        }
    }
}

Start-Sleep -Seconds 3

Write-Host ""

Write-Host "Status of services after script execution:"
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