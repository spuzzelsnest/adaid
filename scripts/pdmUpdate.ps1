#Copy for ticket im0013713381
#
#Created by jan.de-smet@t-systems.com
#

#Location ini file \\de35s024fsv02\VPSX$\PDM_New

$PCName = Read-Host What is the pc name

$source = "\\de35s024fsv02\VPSX$\PDM_New"
$dest =  "\\$PCName\C$\temp"

Copy-Item -Path $source -Destination $dest
.\psexec.exe \\$PCName -s -i cmd "msiexec.exe /i C:\temp\PDM_New\DRVINST64.exe /quiet"  -accepteula