<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Lists all Pipelines in Project
#>


param (
    [string] $organisation,
    [string] $project
)
$personalAccessToken = Read-Host "Enter PAT" -AsSecureString
$PAT = ConvertFrom-SecureString -AsPlainText $personalAccessToken 
$base64AuthInfo= [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo)}
$result = Invoke-RestMethod -Uri "https://dev.azure.com/$organisation/$project/_apis/pipelines?api-version=7.0" -Method Get -Headers $headers 
$result 
