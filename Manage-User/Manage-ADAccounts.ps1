
<#
Author: Stephen Valdinger
(C) 2016 Kent State University
Script provided "AS IS" with no indication of support from any employee of Kent State University.
Use of this utility is at your sole discretion.

.EXAMPLE

Manage-User -Status [disabled/locked] -User [username]

.DESCRIPTION

Management utility to enable support staff to quickly lookup and take action on troubled AD accounts.

#>

Function Manage-User{

#Parameter Declarations
[cmdletBinding()]
Param(
    [ParameterSet(Mandatory=$true,Position=1)]
    [string]$GLOBAL:Status,
    [ParameterSet(Mandatory=$true,Position=2)]
    [switch]$GLOBAL:user

)


If($status -eq 'Locked'){

    Locked
}

Else {

Disabled

}


#Function to unlocked a locked AD Account
Function Locked {

$locked = Search-ADAccount -LockedOut -Usersonly | Where-Object {$_.SAMAccountName -eq $user} | Select-Object -Property SAMAccountName

ForEach($d in $disabled){

    $choice = Read-Host "Would you like to unlock" $d.SAMAccountName "(y/n)?"

    If($choice -eq 'y'){

        Unlock-ADAccount -Identity $d 
        Write-Verbose -Message $d.SAMAccountName "unlocked successfully!"
    }

    Else{
        
        Out-Null

    }
#Close Locked Foreach
}

#Close Locked Function
}

#Function to enable a disabled user account.
Function Disabled {
$disabled = Search-ADAccount -AccountDisabled -Usersonly | Select-Object -Property SAMAccountName

ForEach($d in $disabled){

    $choice = Read-Host "Would you like to enable" $d.SAMAccountName "(y/n)?"

    If($choice -eq 'y'){

        Unlock-ADAccount -Identity $d 
        Write-Verbose -Message $d "enabled successfully!"
    }

    Else{
        
        Out-Null

    }
#close Diabled Foreach loop
}

#Close Diabled Function
}

#Close Manage-User Function
}
