#  ==========================================================================
#
# NAME:		DumpIt.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.mpdesmet@gmail.com
#
# COMMENT: 
#			Dump files in the temp and retrive and move data to local.
#				
#           	
#       VERSION HISTORY:
#       1.0     18.08.2016 - Initial release
#	1.1	25.01.2017 - Destination not copied by psexec
#  ==========================================================================

$src = "dumpFiles" #source folder of the dump files - basically .bat and .ps1 files that can be sent to the pc an result back to server
$PCName = Read-Host "What is the pc-name"
write-host "Can choose from the following Files"
Get-ChildItem $src | select Name
$fileName = Read-Host "What filename will you sent"
$log = "$env:userprofile\desktop\$PCName"
$dest = "\\$PCName\C$\temp" #destenation of the dump file example \\$PCName\C$\temp

#check if pc is online
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){
		Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}else{
	if(!(Test-Path $dest\Logs)){
					New-Item -ItemType Directory -Force -Path $dest\Logs
				}else{
					write-host The $logs directory exsists -foreground "green"
				}
		Copy-Item -Path $src/$filename -Destination $dest -Force -Verbose
		Write-Host $filename copied to $dest -Foreground "green"
		.\PSTools\PsExec.exe -accepteula \\$PCName -s powershell C:\Temp\$filename

#Log files writen to the Agents Desktop

		if(!(Test-path $log)){
				Write-Host $log is not available -Foreground "magenta"
				new-Item $log -type directory -Force
			}else{
				Write-Host Logs will be written to $log -Foreground "green"
			}
#Moving the files to the desktop 

robocopy $dest\logs $log * /Z


#remove the dump files

Remove-Item $dest\$filename -Verbose
Write-Host Files removed from $PCName -Foreground "green"
}
