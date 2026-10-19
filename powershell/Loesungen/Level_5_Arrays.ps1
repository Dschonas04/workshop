# Musterlösung Level 5

# 5.1
$filme = @("Alien", "Brazil", "Casablanca", "Dune", "Fargo")
Write-Host "Erster Film: $($filme[0])"
Write-Host "Letzter Film: $($filme[-1])"
Write-Host "Anzahl: $($filme.Count)"

# 5.2
$ich = @{
    Name  = "Ada"
    Alter = 36
    Hobby = "Schach"
    Essen = "Pizza"
}
Write-Host "$($ich.Name) ist $($ich.Alter) Jahre alt."
Write-Host "Hobby: $($ich.Hobby), Lieblingsessen: $($ich.Essen)"

# 5.3
$filme += "Gattaca"
$ich["Stadt"] = "Berlin"
Write-Host "Jetzt: $($filme.Count) Filme, zuletzt $($filme[-1])"
Write-Host "Stadt: $($ich.Stadt)"

# 5.4
$schüler = @(
    @{ Name = "Anna"; Note = 2 },
    @{ Name = "Ben"; Note = 4 },
    @{ Name = "Clara"; Note = 1 }
)
foreach ($s in $schüler) {
    Write-Host "$($s.Name): Note $($s.Note)"
}

# 5.5
$summe = 0
foreach ($s in $schüler) {
    $summe += $s.Note
}
Write-Host "Durchschnitt: $([math]::Round($summe / $schüler.Count, 2))"
