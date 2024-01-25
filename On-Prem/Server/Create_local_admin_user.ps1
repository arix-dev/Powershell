$NewUser = Read-Host –AsSecureString -Prompt "Enter New Admin User"
$UserPassword = Read-Host –AsSecureString -Prompt "Enter Password"
New-LocalUser $NewUser -Password $UserPassword -FullName $NewUser
Add-LocalGroupMember -Group 'Administrators' -Member ($NewUser) –Verbose
