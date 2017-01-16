#  ==========================================================================
#
# NAME:		massDump.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Dump mass request
#				
#           	
#       VERSION HISTORY:
#       1.0     07.09.2016 - Initial release
#
#  ==========================================================================

$list = Read-Host "TxT file with list of PC "
$fileName = Read-Host "What filename will you sent"
$list = Get-Content D:\GSD\list.txt
foreach ($PCName in $list){

		if(!(Test-Connection -Cn $PCName -BufferSize 16 -count 1 -ea 0 -quiet)){
				Write-host  "PC " $PCName  " is NOT online!!!" -foreground "magenta"
		}else{
				Write-Host "PC " $PCName  "is online, Lets play ball" -Foreground "green"
				
				$src = "\\eudvmmstms202\GSD\dumpfiles"
				$dest = "\\$PCName\C$\temp"
				Copy-Item $src\$filename -Destination $dest -Force -verbose
				
				.\PsExec.exe \\$PCName -s C:\Temp\$filename
				
				if(!(Test-Path $dest\Logs)){
						New-Item -ItemType Directory -Force -Path $dest\Logs
				}else{
						write-host Directory exsists -Foreground "green"
				}
				
				New-Item \\tsclient\V\temp\$PCName -type directory -force
				move-item $dest\Logs  -destination  \\tsclient\V\temp\$PCName -Force
				Remove-Item $dest\$filename
		}
}
