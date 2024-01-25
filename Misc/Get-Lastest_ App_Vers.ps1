<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
===========================================================================
.DESCRIPTION
 Retrieves lastest app versions of common tools
#>
Clear-Host
Write-Host "Visual Studio Code" -ForegroundColor Green
$vscode = Invoke-RestMethod -Uri https://api.github.com/repos/microsoft/vscode/releases/latest
$vscode.html_url 
Write-Host "" 
Write-Host "Terraform" -ForegroundColor Green
$response = Invoke-WebRequest -Uri 'https://checkpoint-api.hashicorp.com/v1/check/terraform' -UseBasicParsing
$data = $response.Content | ConvertFrom-Json
$data.current_download_url + '/terraform_' + $data.current_version + '_windows_amd64.zip'
Write-Host ""
