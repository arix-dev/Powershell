<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
===========================================================================
.DESCRIPTION
 Retrieves GEO location from supplied IP.
#>

Write-Host "Please Enter IP Address to lookup: " -ForegroundColor Green -nonewline; 
$ip = Read-Host
Invoke-RestMethod http://ipinfo.io/$ip -UserAgent 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.1'