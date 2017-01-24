$targetdir = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions"

$extensions = Get-ChildItem $targetdir

Foreach($ext in $extensions){

Set-Location $targetdir\$ext -ErrorAction SilentlyContinue

$folders = (Get-ChildItem).Name

Foreach($folder in $folders){

Set-Location $folder -ErrorAction SilentlyContinue



$json = Get-Content manifest.json | ConvertFrom-Json

$obj = New-Object System.Object

$obj | Add-Member -MemberType NoteProperty -Name Name -Value $json.name
$obj | Add-Member -MemberType NoteProperty -Name Version -Value $json.version

Write-Output $obj
}


}
