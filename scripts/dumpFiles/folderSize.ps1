#  ==========================================================================
#
# NAME:		folderSize.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Check the foldersize from specific folders
#				
#           	
#       VERSION HISTORY:
#       1.0     21.09.2016 - Initial release
#
#  ==========================================================================

$startFolder = read-host What is the start folder
$PCName = read-host "What is the pc-name"

#check if pc is online
If(!(test-connection -Cn $PCName -BufferSize 16 -Count 1 -ea 0 -quiet)){
		Write-host -NoNewline  "PC " $PCName  " is NOT online!!! ... Press any key  " `n
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}else{

		$colItems = (Get-ChildItem $startFolder | Measure-Object -property length -sum)
		"$startFolder -- " + "{0:N2}" -f ($colItems.sum / 1MB) + " MB"

		$colItems = (Get-ChildItem $startFolder -recurse | Where-Object {$_.PSIsContainer -eq $True} | Sort-Object)
		foreach ($i in $colItems){
        $subFolderItems = (Get-ChildItem $i.FullName | Measure-Object -property length -sum)
        $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1MB) + " MB"
    	}