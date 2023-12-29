<#	
.NOTES
===========================================================================
Last updated:	 17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Quick conenctor menu for O365 services.
#>

 Clear-host
 $UPN = Read-Host "Enter UPN you wish to connect to"
 do {

    Write-Host "`n============= M365 Powershell Connector==============" -BackgroundColor Blue
    Write-Host "`t1. Exchange Online"
    Write-Host "`t2. Sharepoint Online"
    Write-Host "`t3. Teams Admin"
    Write-Host "`t4. Security & Compliance Admin"
    Write-Host "`t5. Azure AD"
    Write-Host "`tQ. Quit"
    Write-Host "=====================================================" -BackgroundColor Blue
    $choice = Read-Host "`nEnter Choice"
    } until (($choice -eq '1') -or ($choice -eq '2') -or ($choice -eq '3') -or ($choice -eq '4') -or ($choice -eq '5')-or ($choice -eq 'Q') )
    switch ($choice) {
       '1'{
         Connect-ExchangeOnline -UserPrincipalName $UPN
       }
       '2'{
         try {
            $tenant = Read-Host "`nEnter Tenant (Default: royalcollegecanada)"
            if ([string]::IsNullOrWhiteSpace($tenant))
            {
            $tenant = 'royalcollegecanada'
             }
            Connect-SPOService -Url "https://${tenant}-admin.sharepoint.com"
         }
         catch {}
       }
       '3'{
         Connect-MicrosoftTeams -AccountId $UPN
        }
      '4'{
         Connect-IPPSSession -UserPrincipalName $UPN
      }
      '5'{
         Connect-AzureAD
      }
        'Q'{
          Return
       }
    }