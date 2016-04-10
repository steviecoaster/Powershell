[CmdletBinding()]
Param(
	[Parameter(Mandatory=$True,Position=1)]
		[string]$security,
	[Parameter](Mandatory=$True,Position=2)
		[string]$oldDC,
	[Parameter](Mandatory=$True,Position=3)
		[string]$newDC
)

Function Move-Group {
#Assign group you want to manage to $security
$security = "EPAC Users"

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
