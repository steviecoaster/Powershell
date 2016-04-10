Function Move-Group {
<#
.SYNOPSIS
This function migrates a security group from one Active Directory Domain to the other.

.DESCRIPTION

By supplying a Security Group, and a DC from each the old domain and new domain, Move-Group will pull
all users from the group in the old domain, and place them in the same Security Group on the new domain.

This script does NOT create the group on the new domain at the moment, so ensure the security group exists in both locations before use.

.EXAMPLE

Move-Group -Group "Test" -OldDC dc.olddomain.example -NewDC dc.newdomain.example

.PARAMETER group

The security group to query and migrates

.PARAMETER olddc

The FQDN of a domain controller in the OLD Domain

.PARAMETER newdc

The FQDN of a domain controller in the NEW Domain

#> 
 [CmdletBinding()]
Param(
	[Parameter(Mandatory=$True,Position=1)]
		[string]$group,
	[Parameter](Mandatory=$True,Position=2)
		[string]$oldDC,
	[Parameter](Mandatory=$True,Position=3)
		[string]$newDC
)   
    
    
    
    
#Assign group you want to manage to $security
$security = $group
#Security Group being searched:
$expressCorporate = Get-ADGroupMember -Identity $security -Server $oldDC

#Variable array of all expk user properties
$expkUsers = Get-ADUser -Filter * -Server newDC

#Sanitized list of users from expk
$expkUserArray = @()


#Sanitization loop
Foreach ($expkUser in $expkUsers){

#Add only the name of the user to the new array list.
$expkUserArray += $expkUser.SamAccountName

}

Foreach($user in $expkUserArray){

If ($expressCorporate -match $user){

Write-Host "Match Found: $user added to $security"
Add-ADPrincipalGroupMembership -Identity $user -MemberOf $security -Server $newDC


}

}

}
