<#	
.NOTES
===========================================================================
Last updated:	17 October 2022
Created by:	    Andrew Rix
Organization:   Rixworx Solutions Inc
Working OS:	    Windows
===========================================================================
.DESCRIPTION
 Copies a file to a list of multiple machines specified.
#>

Add-Type -AssemblyName System.Windows.Forms
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.InitialDirectory = $InitialDirectory
$OpenFileDialog.Title = 'Select computer list to open'
$OpenFileDialog.filter = 'Text Files (*.txt)|*.txt'
$OpenFileDialog.ShowDialog() | Out-Null

$OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog2.InitialDirectory = $InitialDirectory
$OpenFileDialog2.Title = 'Select file to copy'
$OpenFileDialog2.filter = 'All Files (*.*)|*.*'
$OpenFileDialog2.ShowDialog() | Out-Null

$filepath = $OpenFileDialog2.FileName
$filename = $OpenFileDialog2.SafeFileName

$computers = Get-Content  $OpenFileDialog.FileName
Write-Host "File will be copied to C:\temp\$filename"
foreach ($comp in $computers)
{
$session = New-PSSession -ComputerName $comp
Copy-Item -Path $filepath -Destination "C:\temp\$filename" -ToSession $session
}
