<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	Windows
	===========================================================================
	.DESCRIPTION
		Remove SMBv1 from machine
#>
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart