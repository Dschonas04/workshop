// Package level3 -- deine Übung zu Level 3.
//
// Die Aufgabenstellung steht in Aufgabenstellung.txt.
package level3

import (
	"errors"
	"fmt"
)

// ErrLeer meldet, dass nichts zu tun war.
var ErrLeer = errors.New("leere Eingabe")

// Former beschreibt alles, was eine Fläche hat.
type Former interface {
	Flaeche() float64
}

// Kreis und Rechteck sollen Former erfüllen.
type Kreis struct{ R float64 }
type Rechteck struct{ B, H float64 }

// AUFGABE 3.1
// Gib Kreis und Rechteck je eine Methode Flaeche, sodass beide
// Former erfüllen. Für den Kreis: math.Pi * R * R.

// AUFGABE 3.2
// Gesamtflaeche summiert die Flächen aller Formen.
// Bei einer leeren Liste: 0 und ErrLeer.
func Gesamtflaeche(formen []Former) (float64, error) {
	return 0, nil // TODO
}

// FeldFehler beschreibt ein ungültiges Feld eines Datensatzes.
type FeldFehler struct {
	Feld  string
	Grund error
}

// AUFGABE 3.3
// Gib FeldFehler eine Error-Methode. Der Text lautet:
//   "Feld <Feld>: <Grund>"
// Gib ihm außerdem eine Unwrap-Methode, die Grund zurückgibt --
// nur dann findet errors.Is den verpackten Fehler.

// ErrZuKurz meldet einen zu kurzen Wert.
var ErrZuKurz = errors.New("zu kurz")

// AUFGABE 3.4
// Pruefe gibt nil zurück, wenn wert mindestens drei Zeichen hat.
// Sonst einen *FeldFehler mit dem Feldnamen und ErrZuKurz als Grund.
func Pruefe(feld, wert string) error {
	return nil // TODO
}

// AUFGABE 3.5
// FeldVonFehler gibt den Feldnamen zurück, wenn irgendwo in der
// Fehlerkette ein *FeldFehler steckt -- auch wenn er verpackt ist.
// Sonst "" und false. Nutze errors.As.
func FeldVonFehler(err error) (string, bool) {
	return "", false // TODO
}

// Damit fmt importiert bleibt, auch bevor du etwas schreibst.
var _ = fmt.Sprintf
