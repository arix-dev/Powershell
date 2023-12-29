Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name MSonline
Install-Module -Name AzureAD
Install-Module -Name Az

# Uncomment if O365 tools needed.
#Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.3
#Install-Module -Name Microsoft.Online.SharePoint.PowerShell
#Install-Module -Name MicrosoftTeams 