// Package abschluss -- Abschlussaufgabe.
// Die Beschreibung steht in Aufgabenstellung.txt.
package abschluss

import (
	"context"
	"errors"
)

// ErrAbbruch meldet, dass die Frist abgelaufen ist.
var ErrAbbruch = errors.New("abgebrochen")

// Quelle liefert Text. Eine Datei, eine Netzantwort, ein Test.
type Quelle interface {
	Name() string
	Text() (string, error)
}

// QuellFehler sagt, welche Quelle versagt hat und warum.
type QuellFehler struct {
	Quelle string
	Grund  error
}

// TODO: Error und Unwrap ergänzen.

// TODO 1
func Zaehle(text string) map[string]int {
	return nil
}

// TODO 2
func Haeufigste(anzahl map[string]int, n int) []string {
	return nil
}

// TODO 3
func ZaehleQuellen(ctx context.Context, quellen []Quelle) (map[string]int, error) {
	return nil, nil
}
