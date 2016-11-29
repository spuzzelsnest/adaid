#  ==========================================================================
#
# NAME:		UserInfo.ps1
#
# AUTHOR:	Jan De Smet
# EMAIL:	jan.de-smet@t-systems.com
#
# COMMENT: 
#			Find user related info from AD.
#				
#           	
#       VERSION HISTORY:
#       1.0     01.07.2015 	- Initial release
#		1.1		19.10.2016 	- Changed layour
#							- Added manager
#
#  ==========================================================================

Param(
[Parameter(Mandatory=$true,Position=1)]
[string]$Id
)

if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PsSnapin Microsoft.Exchange.Management.PowerShell.E2010
}

Write-Host User info -ForegroundColor Green

Get-ADUser -Identity $Id -ErrorAction SilentlyContinue -properties * | select SamAccountName, Name, surName, GivenName,  StreetAddress, PostalCode, City, Country, OfficePhone, otherTelephone, Title, Department, Company, Organization, UserPrincipalName, DistinguishedName, ObjectClass, Enabled,scriptpath, homedrive, homedirectory, SID

#----------------------------------------------

Write-Host Groups -ForegroundColor Green
get-ADPrincipalGroupMembership $Id | select name |Format-Table -HideTableHeaders

#----------------------------------------------

Write-Host Manager -ForegroundColor Green 
$manager = Get-ADUser $Id -Properties manager | Select-Object -Property @{label='Manager';expression={$_.manager -replace '^CN=|,.*$'}} | Format-Table -HideTableHeaders |Out-String
$manager = $manager.Trim()

get-aduser -filter {displayName -like $manager} -properties * | Select displayName, EmailAddress, mobile | Format-List


#----------------------------------------------

Write-Host Email info -ForegroundColor Green

$migAttr = get-aduser -identity $Id -Properties *  -ErrorAction SilentlyContinue | select-object msExchRecipientTypeDetails
Write-Output "Migrations status: " $migAttr
Get-Recipient -Identity $Id | Select Name -ExpandProperty EmailAddresses |  Format-Table Name,  SmtpAddress 
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")