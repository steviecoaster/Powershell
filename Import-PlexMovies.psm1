<#
.SYNOPSIS

Utility to copy content to your Plex Library

.DESCRIPTION

The Import-PlexMovies module provides a simple way to copy movies from any media to your Plex Library Location. It provides output of
the current movie being copied, as well as the total progress of the entire operation.

DISCLAIMER: Use of this software for pirate content, while can't be stopped, is frowned upon. 
Movies are cheap, just buy them and make digital copies, and use this to move them around!



.PARAMETER Source

Supply the path to the removable media you are copying from

.PARAMETER Destination

Supply the path to your Plex Library Movies/TV Shows/etc folder, whatever you need

.EXAMPLE

Import-PlexMovies -Source [jump drive] -Destination [Plex Library location]

#>



Function Import-PlexMovies{
#REGION: Parameter Declarations
[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True,Position=0)]
   [string]$Source,
	
   [Parameter(Mandatory=$True,Position=1)]
   [string]$Destination,
   
   [Parameter(Mandatory=$False,Position=2)]
   [switch]$Analyze,

   [Parameter(Mandatory=$False,Position=3)]
   [switch]$UseExclusion,

   [Parameter(Mandatory=$False,Position=4)]
   [string]$ExclusionFile
)
#END REGION






#REGION: Variable Declaration
$grab = New-Object System.Collections.ArrayList
$ppath = $Destination
$jpath = $Source

If($UseExclusion -eq $true){
If($ExclusionFile -eq ""){

Write-Host "You specified -UseExclusion, please also use -ExclusionFile"

Break

}
$plexmovies = Get-Content $ExclusionFile | Sort-Object

}

Else{

$plexmovies = Get-ChildItem -Path $Destination | Sort-Object

}
$jumpmovies = Get-ChildItem -Path $Source | Sort-Object
$compare = Compare-Object -ReferenceObject $plexmovies -DifferenceObject $jumpmovies | Sort-Object InputObject | Where-Object { $_.SideIndicator -eq '=>' }
$grab = New-Object System.Collections.ArrayList
$onplex = New-Object System.Collections.ArrayList
$onjump = New-Object System.Collections.ArrayList
#END REGION

Foreach($p in $plexmovies){

[void]$onplex.Add($p)

}

Foreach($j in $jumpmovies){

[void]$onjump.Add($j)

}

ForEach($c in $compare) {

[void]$grab.Add($c.InputObject.Name)

}

$grab.Remove("Current Movies Saturday, May 21, 2016.csv")









#REGION: Testing, output counts to screen
Write-host "Plex Server # Movies:" $onplex.Count
Write-Host "Jump Drive # Movies:" $onjump.Count
Write-Host "Movies to copy:" $grab.Count 

#END REGION





#REGION: Copy files


ForEach($flick in $grab){
$i++
If($Analyze){
Copy-Item -Path $jpath\$flick -Destination $ppath\$flick -WhatIf
}
Else{
Copy-Item -Path $jpath\$flick -Destination $ppath\$flick
}
Write-Progress -Activity "Copying Movie: $flick" -Status "Percent Complete:"  -PercentComplete (($i / $grab.Count) * 100)
Write-Verbose "$flick copied successfully!"
}

}

#END REGION


Export-ModuleMember Import-PlexMovies