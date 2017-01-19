#  ==========================================================================
#
# NAME:		onlineStatus.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Check the status of a list of PC's
#				
#           	
#       VERSION HISTORY:
#       1.0     26.09.2016 - Initial release
#
#  ==========================================================================

#read the list of pc
$list =  get-content C:\Users\$env:USERNAME\Desktop\PC-list.txt

foreach ($PCName in $list){

    $status = Test-Connection -ComputerName $PCName -Buffersize 16 -count 1 -quiet 

        if ($status -eq "False") {
                write-host "$PCName is offline " -Foreground "magenta"
        }else {

                Write-Host "$PCName is online" -Foreground "Green"
        }
}
