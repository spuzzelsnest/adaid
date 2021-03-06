#  ==========================================================================
#
# NAME:		Aware-Hunter.ps1
#
# AUTHOR:	Spuzzelsnest
# EMAIL:	jan.mpdesmet@gmail.com
#
# COMMENT: 
#		Comination of the Anti virus tools so far available 
#		- create AVlog Dir on Local C and copy ATTKscan
#		- Set Av Services
#		- Cleanup Temp Files
#		- Regedit anomalies
#           	
#       VERSION HISTORY:
#       1.0     01.07.2015 	- Initial release
#				- Combination of the existing cleanup script + extra's
#  ==========================================================================

#DEF VALUE'S


$PCName = read-host "What is the pc-name"

If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){

Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} else {

		#Def Var + copy Create AVlog Dir and Copy ATTK scan
        new-PSdrive IA Filesystem \\$PCName\C$
        $dest = "IA:\avlog"
        $source = "" #Add Share where ATTK_x64.exe is located
	$log = "" #Add the Log Folder
        $dump = "" #Add the Dump Folder
		
        if(!(Test-Path $dest)){
		
		     New-Item -ItemType Directory -Force -Path $dest
             Write-Host copying attk scan to C:\avlog -ForegroundColor White
             copy-item -path $source -Destination $dest
            }
		if(!(Test-Path $log)){
			New-Item -ItemType Directory -Force -Path $log
			Write-Host Creating Log directory at $log -ForegroundColor Green
					
		}
        if(!(Test-Path $dump)){
             
            New-Item -ItemType Directory -Force -Path $dump
            Write-host Creating Dump Directory on Local PC $dump -foregroundcolor Green
        }      
        
        
	# Setting the Services.
		.\PSTools\PsService.exe \\$PCName setconfig "OfficeScan NT Listener" auto -accepteula
		.\PSTools\PsService.exe \\$PCName setconfig "OfficeScan NT Firewall" auto -accepteula
		.\PSTools\PsService.exe \\$PCName setconfig "OfficeScan NT Proxy Service" auto -accepteula
		.\PSTools\PsService.exe \\$PCName setconfig "OfficeScan NT RealTime Scan" auto -accepteula
		
    # Start Removal 

       	Write-progress "Removing Temp Folders from "  "in Progress:"
	
        remove-item IA:\"$"Recycle.Bin\* -recurse -force -verbose
		Write-host Cleaned up Recycle.Bin -ForegroundColor Green
		
        if (test-Path IA:\Windows\winSXS){
               Remove-Item IA:\windows\winsxs\ -recurse -Force -Verbose
             }else{
                Write-output "No content for winSXS"
        }
        
		
		if (Test-Path IA:\Windows.old){
				Remove-Item IA:\Windows.old\ -Recurse -Force -Verbose
		}else{
				Write-host "no Windows.old Folder found" -ForegroundColor red
		}
		remove-item IA:\temp\* -recurse -force -verbose
		Write-host "Cleaned up C:\temp\" -ForegroundColor Green 
		
		remove-item IA:\Windows\Temp\* -recurse -force -verbose 
		write-host "Cleaned up C:\Windows\Temp" -ForegroundColor Green 

	$UserFolders = get-childItem IA:\Users\ -Directory
	
		foreach ($folder in $UserFolders){
				
					$path = "IA:\Users\"+$folder
					remove-item $path\AppData\Local\Temp\* -recurse -force -verbose -ErrorAction SilentlyContinue
					remove-item $path\AppData\Local\Microsoft\Windows\"Temporary Internet Files"\* -recurse -force -verbose -ErrorAction SilentlyContinue
					Write-host "Cleaned up Temp Items for "$folder.Name -ForegroundColor Green 
		}

.\PSTools\PsExec.exe \\$PCName -s cmd /s /k  "cd C:\avlog && attk_x64.exe && exit"
 
robocopy "\\$PCName\C$\avlog\TrendMicro AntiThreat Toolkit\Output" $log * /Z

net use /delete \\$PCName\C$

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}
