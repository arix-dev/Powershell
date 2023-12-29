<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	Windows
	===========================================================================
	.DESCRIPTION
		Get all O365 users and their assocated O365 licenses
#>

Get-MsolUser -All | where{$_.islicensed -eq "true"} |
Foreach-Object{  
$_.userprincipalname + " | " + $_.licenses.accountSKUId 
}