 <#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Find Empty resource groups in current subscription
#>
 

[CmdletBinding()]
Param(
     [Parameter()]
     $Subscription
 )
$resourceGroups = Get-AzResourceGroup
foreach ($item in $resourceGroups) {
    $resources = Get-AzResource -ResourceGroupName $item.ResourceGroupName
    if($resources){"(" + $item.ResourceGroupName + ") Resource group is not empty"}
    else{"(" + $item.ResourceGroupName + ") Resource group is empty"}
}
