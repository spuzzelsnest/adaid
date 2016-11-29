if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PsSnapin Microsoft.Exchange.Management.PowerShell.E2010
}
$URL = "outlook.office365.com"
$Cred = Get-Credential -Message "I CAN DO ANYTHING"
$ExOPSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://$URL/PowerShell/ -Credential $Cred
Import-PSSession $ExOPSession
