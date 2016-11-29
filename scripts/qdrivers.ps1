#load q drive

$path = C:\Users\tsy_jdesmet\desktop\Qdrives.txt

Get-Content $path| foreach $user in $list 

Write-Output $user

#Get-ADUser -filter { DisplayName -eq "Jacobs Alain" } -properties * |select  homedirectory
