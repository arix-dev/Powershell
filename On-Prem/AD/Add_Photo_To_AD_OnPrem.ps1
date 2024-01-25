<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows
===========================================================================
.DESCRIPTION
	Sets photo in On-Prem Active Directory
#>

# Check for modules installed
$modules = @("ActiveDirectory")        
foreach ($module in $modules) {
    if (Get-Module -ListAvailable -Name $module) {
        Write-Verbose "$module already installed"
    } 
    else {
        Write-Information "Installing $module"
        Install-Module $module -Force -SkipPublisherCheck -Scope CurrentUser -ErrorAction Stop | Out-Null
        Import-Module $module -Force -Scope Local | Out-Null
    }
}

Add-Type -AssemblyName System.Windows.Forms
$user = Read-Host "Please enter samAccountName"
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop')}
$FileBrowser.Title='Choose profile picture'
$FileBrowser.ShowDialog()
$ADphoto = [byte[]](Get-Content $FileBrowser.FileName -Encoding byte)
Set-ADUser $user -Replace @{thumbnailPhoto=$ADphoto}
