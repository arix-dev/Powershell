<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows
===========================================================================
.DESCRIPTION
 Installation of first domain controller in new forest
#>

Install-Windowsfeature -name AD-Domain-Services –IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "domain.com" -InstallDNS -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode Win2008R2 -DomainNetbiosName "DOMAIN"-ForestMode Win2008R2 -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -NoDnsOnNetwork -NoRebootOnCompletion
