<#

Author: Stephen Valdinger, Brandon Bunnelle
Date: 11 April 2016
Prereqs: Windows 7 +, Powershell v2.0 +

This script is written for powershell v2.0, as it is the version that ships with Windows 7 by default.
Later versions of Powershell are backwards compatible, so it's OK to be running a newer version with this script.

Please post any issues running this script to my Issue Tracker here: https://github.com/steviecoaster/Powershell/issues


#>


#Variable declarations for a user with permissions to JOIN a machine to a domain. Change these to suit your environment, the script does the rest.
$user = "Domain\Admin"
$pass = ConvertTo-SecureString "changeme" -AsPlainText -Force
$domain = "FQDN here"
$domainname = "New Domain FQDN Here"

#this creates a PSCredential so the script won't prompt for username/password when it runs, as you've done it programmatically.
$Domaincreds = New-Object System.Management.Automation.PSCredential $domain\$user, $pass



#Take the computer off the existing domain

If((gwmi win32_computersystem).partofdomain -eq $true){

#Take computer off the current domain.
Remove-Computer

#Give powershell time to process
Start-Sleep 3

#GOTO function to join domain
Join-Domain

}

Else{

#If I'm not already a domain member, just join the domain
Join-Domain

}



Function Join-Domain {

Add-Computer -DomainName $domainname -Credential $Domaincreds

Start-Sleep 3

#Force a reboot of the machine, which when it comes back online will be a member of the new domain.
Restart-Computer -Force

}