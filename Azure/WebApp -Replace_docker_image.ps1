<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Replace docker image for Azure web app
#>

$RG = "RWtestRG"
$APPNAME = ""
$DOCKERIMG = ""
$DOCKERREGURL = ""
$DOCKERREGUSR = ""
$DOCKERREGPWD = ""
az webapp config container set --name $APPNAME--resource-group $RG --docker-custom-image-name $DOCKERIMG--docker-registry-server-url $DOCKERREGURL --docker-registry-server-user $DOCKERREGUSR--docker-registry-server-password $DOCKERREGPWD