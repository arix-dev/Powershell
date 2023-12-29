<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows, Linux
===========================================================================
.DESCRIPTION
 Retrieves WHOIS information for domain
#>

$domain = Read-Host -Prompt "Enter domain to query for WHOIS"
#Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ | Format-Table -Property Title, pubDate
$headers=@{}
$headers.Add("x-rapidapi-host", "zozor54-whois-lookup-v1.p.rapidapi.com")
$headers.Add("x-rapidapi-key", "4b67175f76msh20ae9dfe7c906dfp1b8034jsn438d416d03c3")
$response = Invoke-RestMethod -Uri "https://zozor54-whois-lookup-v1.p.rapidapi.com/?domain=$domain" -Method GET -Headers $headers
$response
