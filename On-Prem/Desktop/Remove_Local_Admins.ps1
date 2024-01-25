<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	Windows
	===========================================================================
	.DESCRIPTION
		Remove local admins from remote machines listed in ComputersUsers.csv
#>

Import-Csv "ComputersUsers.csv" | Foreach-Object {    
    $User= $_.Username    
    $PC = $_.ComputerName

Write-Output $PC
$conn = Test-Connection -BufferSize 32 -Count 1 -ComputerName $PC -Quiet 
if ($conn -eq $false)
{
    Write-Output "Unable to connect to $PC"
}
else {
$remotesession = new-pssession -computer $PC
Write-Output "List of local admins before attempting to remove user from group"
invoke-command -scriptblock {Get-LocalGroupMember -Group "Administrators"} -session $remotesession -hidecomputername | Select-Object Name

Invoke-Command -ScriptBlock {Remove-LocalGroupMember -Group "Administrators" -Member $Using:User} -session $remotesession

Write-Output "List of local admins after attempting to remove user from group"
invoke-command -scriptblock {Get-LocalGroupMember -Group "Administrators"} -session $remotesession -hidecomputername | Select-Object Name
Write-Output "`n"
}
} 