$VerbosePreference = 'Continue'

Function Remove-UnknownAccounts{

Param(
[cmdletBinding()]
[Parameter(Mandatory=$true,Position=0)]
[switch]$Unknown

)

Write-Verbose -Message "Starting...."

If($Unknown -eq $true){

Write-Verbose -Message "Moving into HKEY_USERS Hive..."
Set-Location Registry::HKEY_USERS

Write-Verbose -Message "Collecting SIDs"
$SID = ((Get-ChildItem -ErrorAction SilentlyContinue).Name).Substring(11)

}

Foreach($s in $SID){

Write-Verbose -Message "Processing SID: $s on $env:COMPUTERNAME..."
If((Get-CimInstance win32_UserProfile | Select SID,Localpath | Where { $_.SID -match "$s"}) -eq ''){

Get-CimInstance win32_UserProfile | Where { $_.SID -eq $s} | Foreach {$_.Delete()}

Write-Verbose -Message "$s removed from $env:COMPUTERNAME"

}

Else{

Write-Verbose -Message "$s found in WMI User Table"

}

}

Write-Verbose -Message "All SIDS processed. System Cleaned SUCCESSFULLY"

}