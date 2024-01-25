<#	
	.NOTES
	===========================================================================
	 Created on:   	***
	 Created by:   	Andrew Rix
	 Organization: 	Rixworx Solutions Inc
	 Working OS:	Windows
	===========================================================================
	.DESCRIPTION
		Collection of Active Directory functions for admins
#>

Add-Type -AssemblyName System.Windows.Forms
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
function Show-Menu
{
    param (
        [string]$Title = 'Active Directory Tools'
    )
    Clear-Host
    Write-Host "================ $Title ================" -ForegroundColor DarkGreen
    Write-Host "1: Unlock AD Account"
    Write-Host "2: Display Disabled Users"
    Write-Host "3: Display Disabled Computers"
    Write-Host "4: Find Computer by description/user"
    Write-Host "5: Bulk Users to Computers Match"
    Write-Host "Q: Quit"
}
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"  -
     switch ($selection)
     {
         '1'{
            Search-ADAccount -LockedOut | out-gridview -PassThru | Unlock-ADAccount
            } 
         '2'{
            Get-ADUser -Filter {(Enabled -eq $False)} -ResultPageSize 2000 -ResultSetSize $null | out-gridview
            
             
            }
         '3'{
            Get-ADComputer -Filter {(Enabled -eq $False)} -ResultPageSize 2000 -ResultSetSize $null  -Properties Name, OperatingSystem | out-gridview
            }
         '4'
            {
                $u1 = [Microsoft.VisualBasic.Interaction]::InputBox("Enter search term", "Find Computer by description/user")
                $u2 += '*'
                $u2 += $u1
                $u2 += '*'
                Get-ADComputer -Filter  {Description -like $u2} |Out-GridView
            }
         '5'
            {
            $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
            $FileBrowser.
            $null = $FileBrowser.ShowDialog()
            if ($FileBrowser.FileName == null)
            {
            $computers = gc -Path $FileBrowser.FileName
            $arraylist = New-Object System.Collections.Arraylist
             foreach ($i in $computers)
            {
                $arraylist.add($(Get-ADComputer $i -Properties * | Select-Object Name,Description)) | Out-Null
            }
            $arraylist | Export-Csv ADComputerstoUsers.csv
            Write-Output "Saved to $PSScriptRoot\ADComputerstoUsers.csv"
            }
            }   
     }
     pause
 }
 until ($selection -eq 'q')
