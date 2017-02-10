Function Add-Fonts{
    Param(
        [cmdletBinding()]
        [parameter(Mandatory=$true,Position=0)]
        [string]$Source

    )


    $dest = 'C:\Windows\Fonts' #default font location
    $files = Get-ChildItem -Path $Source
    $Exclude = @()



#Logic
    ForEach($file in $files){
       If (Test-Path "$dest\$file"){
           $Exclude += $file
           } #end if
    
            Copy-Item "$source\$file" -Destination $dest -Exclude $Exclude -Force

            $type = $file.Extension

                If($type -eq ".otf"){

                Set-Location 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'

                New-ItemProperty -Path . -Name "$($file.Name -replace ".{4}$") (OpenType)" -Type String -Value $file.name

                } #end type if

                ElseIf($type -eq ".ttf"){

                Set-Location 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'

                New-ItemProperty -Path . -Name "$($file.Name -replace ".{4}$") (TrueType)" -Type String -Value $file.name

                } #end type elseif



        } #end foreach

} #end function


#Call file wtih ./Add-fonts.ps1 -Source <your source dir on the system>