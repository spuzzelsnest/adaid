#  ==========================================================================
#
# NAME:		locCleanup.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Clean the pc locally.
#				
#           	
#       VERSION HISTORY:
#       1.0     01.09.2016 - Initial release
#
#  ==========================================================================

remove-item C:\"$"Recycle.Bin\* -recurse -force -verbose
if (Test-Path C:\Windows.old) {	
		Remove-Item C:\windows.old\* -Recurse -Force -Verbose
	}else{
		Write-Host "No Old windows Folder"
}
if (Test-Path C:\Windows\WinSXS) { 
		remove-item C:\Windows\WinSXS\* -recurse -force -verbose
	}else{
		Write-Host "No WinSXS folder found"
	}
	
Write-Host "Checking Users folder"

$users = Get-ChildItem C:\Users\ -Directory
Foreach ($user in $users){ 
	remove-Item C:\Users\$user\AppData\Local\Temp\* -recurse -force -verbose -ErrorAction SilentlyContinue
	remove-Item C:\Users\$user\AppData\Local\Microsoft\Windows\"Temporary Internet Files"\* -recurse -force -verbose -ErrorAction SilentlyContinue
	Remove-Item C:\Users\$user\Appdata\Local\Microsoft\Office\15.0\OfficeFileCache\* -Recurse -Force -Verbose -ErrorAction SilentlyContinue
}