Function Hail-Insult {

Add-Type -AssemblyName System.Speech

$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

$speak.Rate = 0
$speak.SelectVoiceByHints("female")

$insults = ("You smell like burnt gym socks", "Why don't you do yourself a favor and die", "If you were any dumber I'd start calling you my ex-wife")

$speak.Speak((Get-Random($insults)))

}

Export-ModuleMember -Function Hail-Insult