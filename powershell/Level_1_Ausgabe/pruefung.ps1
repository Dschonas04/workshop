# Level 1: Ausgabe. Geprüft wird nicht nur der Text, sondern auch,
# auf welchem Weg er herauskommt.
$alles = Starte $Ziel
$ohneHost = Starte $Ziel -Umleitung '6>$null'
$ohneWarnung = Starte $Ziel -Umleitung '3>$null'

Pruefe '1.1 Begrüßung erscheint' (Zeile $alles 1) 'Hallo, PowerShell!'
Pruefe '1.1 ... und kommt von Write-Host' (($alles -contains 'Hallo, PowerShell!') -and -not ($ohneHost -contains 'Hallo, PowerShell!')) $true
Pruefe '1.2 Name kommt von Write-Output' ($ohneHost -contains 'Ada') $true
Pruefe '1.3 Warnung erscheint' ([bool]($alles -match 'PowerShell lernen macht süchtig!')) $true
Pruefe '1.3 ... und ist eine Warnung' ([bool]($alles -match 'PowerShell lernen macht süchtig!') -and -not [bool]($ohneWarnung -match 'PowerShell lernen macht süchtig!')) $true
$i = [array]::IndexOf($ohneHost, 'Apfel')
Pruefe '1.4 Früchte sortiert aus der Pipeline' ($(if ($i -ge 0) { $ohneHost[$i..($i + 2)] } else { @() })) @('Apfel', 'Banane', 'Kirsche')
