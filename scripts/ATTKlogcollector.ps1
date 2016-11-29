#  ==========================================================================
#
# NAME:		ATTKlogcollector.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Run the ATTK logcollector on a remote pc
#				
#           	
#       VERSION HISTORY:
#       1.0     22.06.2016 - Initial release
#
#  ==========================================================================


$PCName = read-host "What is the pc-name"
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){
echo "PC "$PCNAME" is NOT online!!!"
} else {
		
		$src = "\\eudvmmstms202\GSD\AV\attk_x64.exe"
		$dest = "\\$PCName\C$\avlog"
		
		
		if(!(Test-Path $dest)){
				New-Item -ItemType Directory -Force -Path $dest
		}else{
				write-host Directory exsists -Foreground "green"
		}
		Copy-Item $src -Destination $dest -Force -verbose
		#.\psexec.exe \\$PCNAME -s cmd  /c copy \\Eudvmmstms202\gsd\AV\attk_x64.exe C:\avlog\
		.\psexec.exe \\$PCNAME -s C:\avlog\attk_x64.exe

}