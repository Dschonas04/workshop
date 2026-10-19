# Musterlösung Level 2

# 2.1
$name = "Ada"
$alter = 36
Write-Host "Ich heiße $name und bin $alter Jahre alt."

# 2.2
Write-Host "name ist: $($name.GetType().Name)"
Write-Host "alter ist: $($alter.GetType().Name)"

# 2.3
$istStudentin = $false
Write-Host "$name ist $alter Jahre alt, Studentin: $istStudentin"

# 2.4
$a = "10"
$b = 20
Write-Host ($a + $b)   # links steht ein String: 20 wird zu "20" und angehängt
Write-Host ($b + $a)   # links steht eine Zahl: "10" wird zu 10 und addiert
