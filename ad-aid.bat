::AD-AID.bat
::AD Tool for additional information 
::
::Created by Jan De Smet
::
::Change Log
::-----------
::V1.0 Initial release 04-03-2016
::############################################
@echo off
mode con:cols=140 lines=100
title AD-Aid
cls
cd scripts
:start
echo                                          sssss:Sss:Sss
echo                                     ss:===:Ssss:Ssss:Sss:s
echo                      ____________ sss:==:Ss# X Ss:Sss:Ssss:Sss
echo                      ````\\\\\\\\\~~~ss===s X+X S:Sss:Ss:Sssss:Ss
echo                               vvvv ==== ss   X S:Sss:Ss :Ss:Ssss:Sss
echo                              vv  v ====  s  /   ss:Sss Sss:Ss:Ssss:Sss:s
echo                               vvv          X     ss:S s:S s:Sss:Sssss:Sss
echo                                u     __   X+X   s:S s:Ss :Sss Ss:Ss s:Sssss
echo                                uu   /@@    X       s:Ss Ssss ss:Ss sss:Ssss:s
echo                                 uu         X         s :Sss s:Sss ss:Sssssss:s
echo                                   u       X+X      )  Ssss sssss Ssssss :Ssssss:
echo                                   u        X      ) \  S: sss:S ssss:S sss:S :sss
echo                                   u       /      /   `\  Ssss:  Sss:s  ssSs:  sssss
echo                                   uu     X      u      \  Ss     Sss    Sss     Ssss_
echo                                   u @@) (_)   u'        \ s      ss      s        S  \_
echo                                   \u    u u  u           \        s
echo                                    \uuu/  uu/             \
echo                                                            .
echo                                                            .
echo                                                            /
echo                                                           /
echo                                            __________    .
echo                                           /          \. /
echo                                          /   __       \.
echo                                         /___/
echo .
echo                                   Hello  %UserName%  
echo                                   Welcome to AD-Aid (v1.05)
echo                      Press:
echo                               (1)   User info
echo                               (2)   PC info
echo                               (3)   Antivirus Tools
echo                               (4)   User Loggedon to PC
echo                               (5)   Exit
echo	.
choice /c 12345 /M "Let's see, what u want to do?"

if Errorlevel 5 goto 5
if Errorlevel 4 goto 4
if Errorlevel 3 goto 3
if Errorlevel 2 goto 2
if Errorlevel 1 goto 1

Goto End

:1
cls
powershell.exe .\UserInfo.ps1
cd ..
Goto End

:2
cls
powershell.exe .\PcInfo.ps1
cd ..
Goto End

:3
cls
echo                               (1)   Clean TEMP folders
echo                               (2)   Set AV Services
echo                               (3)   Aware-Hunter 
choice /c 123 /M "Let's see, what u want to do?"

if ErrorLevel 1 goto 21
if ErrorLevel 2 goto 22
if ErrorLevel 3 goto 23
Goto End

:21
cls
powershell.exe .\Cleanup.ps1
cd..
Goto END

:22
cls
powershell.exe .\SetAVServices.ps1
cd..
Goto END

:23
cls
powershell.exe .\aware-hunter.ps1
cd..
Goto END

:4
cls
powershell.exe .\Loggedon.ps1
cd ..
Goto End

:5
cls
:End