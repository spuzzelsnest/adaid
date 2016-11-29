#  ==========================================================================
#
# NAME:		rangeDump.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Dump mass request
#				
#           	
#       VERSION HISTORY:
#       1.0     05.10.2016 - Initial release
#
#  ==========================================================================

$range = read-Host "what is the ip range.(XX.XX.XX) "
$x = 2..254 | % { "$range.$_ `n"}  

Write-Host $x