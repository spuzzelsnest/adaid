#  ==========================================================================
#
# NAME:		DumpIt.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Dump files in the temp and retrive and move data to local.
#				
#           	
#       VERSION HISTORY:
#       1.0     18.08.2016 - Initial release
#
#  ==========================================================================

$PCName = read-host "What is the pc-name"
$fileName = Read-Host "What filename will you sent"
$cred = Get-Credential $(whoami)
$log = "\\tsclient\V\temp\$PCName"

#check if pc is online
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){
		Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}else{
		$src = "\\eudvmmstms202\GSD\dumpfiles"
		$dest = "\\$PCName\C$\temp"
				if(!(Test-Path $dest\Logs)){
					New-Item -ItemType Directory -Force -Path $dest\Logs
				}else{
					write-host The $logs directory exsists -foreground "green"
				}
		.\psexec.exe -accepteula \\$PCName -s cmd /c copy $src\$fileName $dest
		Write-Host $filename copied to $dest -Foreground "green"
		.\PsExec.exe -accepteula \\$PCName -s powershell C:\Temp\$filename
}
#check if the V drive is online 
		if(!(Test-path $log)){

				Write-Host V drive is offline, No logs will be writen -Foreground "magenta"

			}else{

				Write-Host V drive is online, Logs will be written to $log -Foreground "green"
				New-Item \\tsclient\V\temp\$PCName -type directory -force
				move-item $dest\Logs  -destination $log -Force
}

#remove the dump files

Remove-Item $dest\$filename -Verbose
Write-Host Files removed from $PCName -Foreground "green"