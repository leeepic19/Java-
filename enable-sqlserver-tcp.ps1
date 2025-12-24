# Enable SQL Server TCP/IP Protocol
# This script must be run as Administrator

Write-Host "Enabling SQL Server TCP/IP Protocol..." -ForegroundColor Yellow

# Import SQL Server Management Objects
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | Out-Null
$wmi = New-Object Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer

# Get the SQL Server instance
$uri = "ManagedComputer[@Name='$env:COMPUTERNAME']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"
$tcp = $wmi.GetSmoObject($uri)

if ($tcp) {
    Write-Host "Current TCP/IP Status: $($tcp.IsEnabled)" -ForegroundColor Cyan
    
    if (-not $tcp.IsEnabled) {
        Write-Host "Enabling TCP/IP..." -ForegroundColor Green
        $tcp.IsEnabled = $true
        $tcp.Alter()
        Write-Host "TCP/IP has been enabled!" -ForegroundColor Green
        Write-Host "Restarting SQL Server service..." -ForegroundColor Yellow
        
        # Restart SQL Server service
        Restart-Service -Name "MSSQLSERVER" -Force
        Write-Host "SQL Server service restarted successfully!" -ForegroundColor Green
    } else {
        Write-Host "TCP/IP is already enabled." -ForegroundColor Green
        Write-Host "Checking port configuration..." -ForegroundColor Yellow
        
        # Get IP All configuration
        $ipAll = $tcp.IPAddresses | Where-Object { $_.Name -eq 'IPAll' }
        if ($ipAll) {
            Write-Host "  TCP Port: $($ipAll.IPAddressProperties['TcpPort'].Value)" -ForegroundColor Cyan
            Write-Host "  Dynamic Port: $($ipAll.IPAddressProperties['TcpDynamicPorts'].Value)" -ForegroundColor Cyan
            
            # Set static port if not set
            if ([string]::IsNullOrEmpty($ipAll.IPAddressProperties['TcpPort'].Value)) {
                Write-Host "Setting static port to 1433..." -ForegroundColor Yellow
                $ipAll.IPAddressProperties['TcpDynamicPorts'].Value = ''
                $ipAll.IPAddressProperties['TcpPort'].Value = '1433'
                $tcp.Alter()
                Write-Host "Port configured. Restarting SQL Server..." -ForegroundColor Yellow
                Restart-Service -Name "MSSQLSERVER" -Force
                Write-Host "Done!" -ForegroundColor Green
            }
        }
    }
} else {
    Write-Host "ERROR: Could not find TCP protocol for MSSQLSERVER instance." -ForegroundColor Red
    Write-Host "Please enable TCP/IP manually using SQL Server Configuration Manager." -ForegroundColor Yellow
}

Write-Host "`nPress any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
