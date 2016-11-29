#  ==========================================================================
#
# NAME:		Loggedon.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jand.De-Smet@t-systems.com
#
# COMMENT: 
#			Get Available users from PC-name
#				
#           	
#       VERSION HISTORY:
#       1.0     01.01.2016 - Initial release
#
#  ==========================================================================



$PCName = read-host "What is the pc-name"
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){

Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} else {
.\PsLoggedon.exe /l \\$PCName -accepteula

Write-Host Other USERID´s in this PC.
Get-ChildItem  \\$PCName\C$\Users\

Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}