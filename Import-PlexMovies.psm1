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
   [string]$Destination
)
#END REGION

#REGION: Variable Declaration
$grab = New-Object System.Collections.ArrayList
$onplex = New-Object System.Collections.Arraylist
$onjump = New-Object System.Collections.ArrayList

$ppath = $Destination
$jpath = $Source

$plexmovies = Get-ChildItem -Path $Destination | Sort-Object
$jumpmovies = Get-ChildItem -Path $Source | Sort-Object
#END REGION

#REGION: Plex titles to ArrayList
Foreach($pm in $plexmovies){

[void]$onplex.Add($pm)

}

#END REGION

#REGION: Jump titles to Arraylist
Foreach($jm in $jumpmovies){

[void]$onjump.Add($jm)

}

#END REGION

#REGION: ArrayList Comparison to Differences Arraylist
ForEach($j in $onjump){

    If ($onplex -notcontains $j){

    [void]$grab.Add($j)

    }

}

#END REGION

#REGION: Testing, output counts to screen
Write-host "Plex Server # Movies:" $onplex.Count
Write-Host "Jump Drive # Movies:" $onjump.Count
Write-Host "Movies to copy:" $grab.Count 

#END REGION

#REGION: Copy files
ForEach($flick in $grab){
$i++
Copy-Item -Path $jpath\$flick -Destination $ppath\$flick
Write-Progress -Activity "Copying Movie: $flick" -Status "Percent Complete:" (($i / $grab.Count) * 100) -PercentComplete 

}

#END REGION

#REGION: Plex movie list to CSV


#END REGION

}

Export-ModuleMember Import-PlexMovies
