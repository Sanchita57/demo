# Function to start 
function Start-ServiceOrFail {
    param(
        [string]$serviceName
    )

    $service = Get-Service -Name $serviceName
    if ($service.status -eq 'Stopped') {
        try {
            Start-Service -Name $serviceName -ErrorAction Stop
            Write-Host "Service $serviceName started successfully."
        }
        catch {
            Write-Host "Failed to start servie $serviceName"
            exit 1
        }
    }
    else {
        Write-Host "Service $serviceName is already running."
    }
}


#Function to stop
function Stop-ServiceOrFail {
    param (
        [string]$serviceName
    )

    $service = Get-Service -Name $serviceName
    if ($service.Status -eq 'Running') {
        try {
            Stop-Service -Name $serviceName -ErrorAction Stop
            Write-Host "Service $serviceName stopped successfully."
        }
        catch {
            Wrtie-Host "Failed to stop service $serviceName"
            exit 1
        }
    }
    else {
        Write-Host "Service $serviceName is already stopped."
    }
}

#configfile
#$configFile = "C:\services_config.json"
#$config= Get-Content -Raw -Path "C:\services_config.json" | ConvertFrom-Json

#$servicesToStart = @("Themes", "Spooler")
$servicesToStart= ("Audiosrv")
$servicesToStop= ("winRM", "Spooler")

#start or stop service
foreach ($service in $servicesToStart) {
    Start-ServiceOrFail -serviceName $service
}

foreach ($service in $servicesToStop) {
    Stop-ServiceOrFail -serviceName $service
}