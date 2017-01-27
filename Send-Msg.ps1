<#
.SYNOPSIS

Wrapper function for the built in msg command on Windows.

.DESCRIPTION

This script takes arguments from the function and forumlates a proper msg command.

.PARAMETER Username

The logged on user session to display the message in.

.PARAMETER Computer

The remote computer on which to display the message.

.PARAMETER MessageText

The content of the Message to be displayed.

.EXAMPLE

Send-Msg -Username joebob -Computer Wrkst01 -MessageText "This is a message from your friendly Sysadmin!"

#>






Function Send-Msg{

  Param(

  [cmdletBinding()]
  [Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true)]
  [string]$Username,
  [Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$true)]
  [string]$Computer,
  [Parameter(Mandatory=$true,Position=2)]
  [string]$MessageText

  )

  Start-Process msg -ArgumentList "$Username", "/server:$Computer", "$MessageText" -NoNewWindow

}
