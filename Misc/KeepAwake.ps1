<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	  Windows
	===========================================================================
	.DESCRIPTION
		Sends F15 key every minute to keep screen alive
#>

$wsh = New-Object -ComObject WScript.Shell
while (1) {
  $wsh.SendKeys('+{F15}')
  Write-host 'Sent F15'
  Start-Sleep -seconds 59
}