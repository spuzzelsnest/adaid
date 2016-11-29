::conReset.bat
::Reset Network Connections 
::
::Created by Jan De Smet
::
::Change Log
::-----------
::V1.0 Initial release 24-08-2016
::############################################
@echo off
ipconfig /reslease > restult.log
ipconfig /flushdns >> result.log
netsh winsock reset
netsh int ip reset resetlog.txt
netsh int reset all
netsh routing reset all
netsh routing dump
