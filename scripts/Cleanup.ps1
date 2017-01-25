#  ==========================================================================
#
# NAME:		Cleanup.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Clean Temp Folders.
#				
#           	
#       VERSION HISTORY:
#       1.0     01.01.2016 	- Initial release
#		1.1     16.08.2016 	- added Windows.old removal
#		1.2	20.10.2016 	- Removed Credentials
#					- Added Layout Color
#
#  ==========================================================================

$PCName = read-host "What is the pc-name"
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){

Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

} else {
		Write-progress "Removing Temp Folders from "  "in Progress:"
		new-PSdrive IA Filesystem \\$PCName\C$ 

		remove-item IA:\"$"Recycle.Bin\* -recurse -force -verbose
		Write-Output "Cleaned up Recycle.Bin"
		
		if (Test-Path IA:\Windows.old){
				Remove-Item IA:\Windows.old\ -Recurse -Force -Verbose
				}else{
				Write-Output "no Windows.old Folder found" 
				}
		remove-item IA:\temp\* -recurse -force -verbose
		Write-output "Cleaned up C:\temp\"
		
		remove-item IA:\Windows\Temp\* -recurse -force -verbose
		write-output "Cleaned up C:\Windows\Temp"

	$UserFolders = get-childItem IA:\Users\ -Directory
	
		foreach ($folder in $UserFolders){
				
					$path = "IA:\Users\"+$folder
					remove-item $path\AppData\Local\Temp\* -recurse -force -verbose -ErrorAction SilentlyContinue
					remove-item $path\AppData\Local\Microsoft\Windows\"Temporary Internet Files"\* -recurse -force -verbose -ErrorAction SilentlyContinue
					Write-Output "Cleaned up Temp Items for "$folder.Name	
		}
net use /delete \\$PCName\C$
}
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
