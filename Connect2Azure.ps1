<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Authenticates to Azure and let you select subscription.
#>

if ([string]::IsNullOrEmpty($(Get-AzContext).Account)) {Connect-AzAccount | Out-Null} # Check if Azure is already authenticated
Clear-Host
Write-Host "Azure Subscription Selection`n" -ForegroundColor Green 
$subs =  Get-AzSubscription
$menu = @{}
for ($i=1;$i -le $subs.count; $i++) 
{ Write-Host "$i. $($subs[$i-1].name)$($subs[$i-1].status)" 
$menu.Add($i,($subs[$i-1].name))}

[int]$ans = Read-Host 'Enter Subscription selection'
$selection = $menu.Item($ans) ; Set-AzContext $selection
