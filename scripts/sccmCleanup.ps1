#  ==========================================================================
#
# NAME:		SetAVServices.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Remotely set the Services for MicroTrend.
#				
#           	
#       VERSION HISTORY:
#       1.0     01.12.2015 - Initial release
#
#  ==========================================================================

$PCName = read-host "What is the pc-name"
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){
Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} else {
$creds = $whoami
.\PsService.exe \\$PCName setconfig "OfficeScan NT Listener" auto -accepteula
.\PsService.exe \\$PCName setconfig "OfficeScan NT Firewall" auto -accepteula
.\PsService.exe \\$PCName setconfig "OfficeScan NT Proxy Service" auto -accepteula
.\PsService.exe \\$PCName setconfig "OfficeScan NT RealTime Scan" auto -accepteula


Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


}
