// Musterlösung zu Level 3.
package level3

import (
	"errors"
	"math"
)

var ErrLeer = errors.New("leere Eingabe")

type Former interface {
	Flaeche() float64
}

type Kreis struct{ R float64 }
type Rechteck struct{ B, H float64 }

func (k Kreis) Flaeche() float64    { return math.Pi * k.R * k.R }
func (r Rechteck) Flaeche() float64 { return r.B * r.H }

func Gesamtflaeche(formen []Former) (float64, error) {
	if len(formen) == 0 {
		return 0, ErrLeer
	}
	var summe float64
	for _, f := range formen {
		summe += f.Flaeche()
	}
	return summe, nil
}

type FeldFehler struct {
	Feld  string
	Grund error
}

func (e *FeldFehler) Error() string {
	return "Feld " + e.Feld + ": " + e.Grund.Error()
}

// Ohne Unwrap fände errors.Is den Grund nicht.
func (e *FeldFehler) Unwrap() error { return e.Grund }

var ErrZuKurz = errors.New("zu kurz")

func Pruefe(feld, wert string) error {
	if len(wert) >= 3 {
		return nil
	}
	return &FeldFehler{Feld: feld, Grund: ErrZuKurz}
}

func FeldVonFehler(err error) (string, bool) {
	var f *FeldFehler
	if errors.As(err, &f) {
		return f.Feld, true
	}
	return "", false
}
