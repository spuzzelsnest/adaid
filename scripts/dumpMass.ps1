#  ==========================================================================
#
# NAME:		dumpMass.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.mpdesmet@gmail.com
#
# COMMENT: 
#			Dump mass request
#				
#           	
#       VERSION HISTORY:
#       1.0     07.09.2016 - Initial release
#
#  ==========================================================================

Write-Host "Make sure you have create the PC-list.txt file on your Desktop"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
$list =  get-content C:\Users\$env:USERNAME\Desktop\PC-list.txt
$src = "dumpFiles" #source folder of the dump files - basically .bat and .ps1 files that can be sent to the pc an result back to server
write-host "Can choose from the following Files"
Get-ChildItem $src | select Name
$fileName = Read-Host "What file do you want to send"
$PCName = Read-Host "What is the pc-name"
foreach ($PCName in $list){

		if(!(Test-Connection -Cn $PCName -BufferSize 16 -count 1 -ea 0 -quiet)){
				Write-host  "PC " $PCName  " is NOT online!!!" -foreground "magenta"
		}else{
				Write-Host "PC " $PCName  "is online, Lets play ball" -Foreground "green"
				$dest = "\\$PCName\C$\temp"
				
				if(!(Test-Path $dest\Logs)){
						New-Item -ItemType Directory -Force -Path $dest\Logs
				}else{
						write-host Directory exsists -Foreground "green"
				}
				
				Copy-Item $src\$filename -Destination $dest -Force -verbose
				.\PSTools\PsExec.exe \\$PCName -s C:\Temp\$filename
				
				New-Item \\tsclient\V\temp\$PCName -type directory -force
				move-item $dest\Logs  -destination  \\tsclient\V\temp\$PCName -Force
				Remove-Item $dest\$filename
		}
}
