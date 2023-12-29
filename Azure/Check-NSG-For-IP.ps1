<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Checks all network security groups in current subscription for your IP
#>

Clear-Host
$j = curl -s 'https://ipinfo.io' | ConvertFrom-Json
$myIP = Read-Host "Please enter your IP(" + $j.ip + ")"
if ([string]::IsNullOrWhiteSpace($myIP))
{
$myIP =$j.ip
}

$NSGs = Get-AzNetworkSecurityGroup
foreach ($nsg in $NSGs)
{
    Write-Host "Checking"$nsg.Name -ForegroundColor Green
    Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg | Select-Object Name,SourceAddressPrefix | Where-Object {$_.SourceAddressPrefix -eq $myIP}
}