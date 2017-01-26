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