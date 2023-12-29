<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	  Windows, Linux
	===========================================================================
	.DESCRIPTION
		Retrieves current MFA status and authentication method of users in a gridview or html.
  .EXAMPLE
    Get-O365MFAUserStatus.ps1 -Output html
#>

 
Param (
  [Parameter()]
    [string]$output
)



try
{
    Get-MsolDomain -ErrorAction Stop > $null
}
catch 
{
    Write-Output "Not alfeady connected. Connecting to Office 365..."
    Connect-MsolService 
}

if ($output -eq 'html')
{

try{
  $header = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
    font-family: Arial, Helvetica, sans-serif;
  } 
	
  td {
  padding: 4px;
  margin: 0px;
  border: 0;
}

  th {
      background: #395870;
      background: linear-gradient(#49708f, #293f50);
      color: #fff;
      font-size: 11px;
      text-transform: uppercase;
      padding: 10px 15px;
      vertical-align: middle;
}

  tbody tr:nth-child(even) {
      background: #f0f0f2;
  }

      #CreationDate {

      font-family: Arial, Helvetica, sans-serif;
      color: #ff3300;
      font-size: 12px;

  }
  </style>
"@

$Result=@() 
$users = Get-MsolUser -All
$users | ForEach-Object {
$user = $_
$mfaStatus = $_.StrongAuthenticationRequirements.State 
$methodTypes = $_.StrongAuthenticationMethods 
 
if ($mfaStatus -ne $null -or $methodTypes -ne $null)
{
if($mfaStatus -eq $null)
{ 
$mfaStatus='Enabled (Conditional Access)'
}
$authMethods = $methodTypes.MethodType
$defaultAuthMethod = ($methodTypes | Where-Object{$_.IsDefault -eq "True"}).MethodType 
$verifyEmail = $user.StrongAuthenticationUserDetails.Email 
$phoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
$alternativePhoneNumber = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
}
Else
{
$mfaStatus = "Disabled"
$defaultAuthMethod = $null
$verifyEmail = $null
$phoneNumber = $null
$alternativePhoneNumber = $null
}
    
$Result += New-Object PSObject -property @{ 
"Display Name" = $user.DisplayName
"User Principal Name" = $user.UserPrincipalName
"MFA Status" = $mfaStatus
"Authentication Methods" = Out-String -InputObject $authMethods
"Current Auth Method" = $defaultAuthMethod
"MFA Email" = $verifyEmail
"Phone Number" = $phoneNumber
"Alternative Phone Number" = $alternativePhoneNumber
}
}
$ResultInfo = $Result |Sort-Object "Display Name" | ConvertTo-Html -Property "Display Name","User Principal Name","MFA Status","Current Auth Method","Authentication Methods","MFA Email","Phone Number","Alternative Phone Number" -Fragment
$Report = ConvertTo-HTML -Body "$ResultInfo" -Head $header -Title "O365 User MFA Report" -PreContent "<p id='CreationDate'>Creation Date: $(Get-Date)</p>"

#The command below will generate the report to an HTML file
$Report | Out-File ".\\O365 User MFA Report.html"
}
catch {
    "Failed to get details."
}
}
else {
  try{
  
  
  $Result=@() 
  $users = Get-MsolUser -All
  $users | ForEach-Object {
  $user = $_
  $mfaStatus = $_.StrongAuthenticationRequirements.State 
  $methodTypes = $_.StrongAuthenticationMethods 
   
  if ($mfaStatus -ne $null -or $methodTypes -ne $null)
  {
  if($mfaStatus -eq $null)
  { 
  $mfaStatus='Enabled (Conditional Access)'
  }
  $authMethods = $methodTypes.MethodType
  $defaultAuthMethod = ($methodTypes | Where-Object{$_.IsDefault -eq "True"}).MethodType 
  $verifyEmail = $user.StrongAuthenticationUserDetails.Email 
  $phoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
  $alternativePhoneNumber = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
  }
  Else
  {
  $mfaStatus = "Disabled"
  $defaultAuthMethod = $null
  $verifyEmail = $null
  $phoneNumber = $null
  $alternativePhoneNumber = $null
  }
      
  $Result += New-Object PSObject -property @{ 
  "Display Name" = $user.DisplayName
  "User Principal Name" = $user.UserPrincipalName
  "MFA Status" = $mfaStatus
  "Authentication Methods" = $authMethods
  "Current Auth Method" = $defaultAuthMethod
  "MFA Email" = $verifyEmail
  "Phone Number" = $phoneNumber
  "Alternative Phone Number" = $alternativePhoneNumber
  }
  }
  $Result | Select-Object "Display Name","MFA Status","Current Auth Method","Authentication Methods","MFA Email","Phone Number","Alternative Phone Number"| Out-GridView

  }
  catch {
      "Failed to get details."
  }
  
}