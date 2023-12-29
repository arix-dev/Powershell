<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Removes newlines from text file
#>

(gc args[0]) | ? {$_.trim() -ne "" } | set-content args[0]