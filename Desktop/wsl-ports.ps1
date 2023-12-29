wsl sudo service ssh start
$Ports = (2222,80,443,8080)
$WSLIP = wsl -- ip -o -4 -json addr list eth0 | ConvertFrom-Json | %{ $_.addr_info.local } | ?{ $_ }


# If elevation needed then stop
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
   }
}

# Remove and Create NetFireWallRule
Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -ErrorAction SilentlyContinue;
if ($Args[0] -ne "delete") {
  New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $Ports -Action Allow -Protocol TCP;
  New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $Ports -Action Allow -Protocol TCP;
}

# Add each port
$listenAddr = "0.0.0.0"
Foreach ($Port in $Ports) {
    iex "netsh interface portproxy delete v4tov4 listenaddress=$listenAddr listenport=$Port | Out-Null";
    if ($Args[0] -ne "delete") {
        iex "netsh interface portproxy add v4tov4 listenaddress=$listenAddr listenport=$Port connectaddress=$WSLIP connectport=$Port | Out-Null";
    }
}

# Display all portproxy information
netsh interface portproxy show v4tov4;