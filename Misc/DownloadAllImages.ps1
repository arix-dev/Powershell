<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
===========================================================================
.DESCRIPTION
 Downloads all images from url
#>
Write-Host "Please enter Url to downlaod images " -ForegroundColor Green -nonewline; 
$Url= Read-Host
$iwr = Invoke-WebRequest -Uri $Url
$images = ($iwr).Images | select src
$images
