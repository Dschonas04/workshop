// Package level4 -- deine Übung zu Level 4.
//
// Die Aufgabenstellung steht in Aufgabenstellung.txt.
package level4

import (
	"context"
	"errors"
	"sync"
	"time"
)

var _ = sync.WaitGroup{}
var _ = time.Second

// ErrAbbruch meldet, dass die Frist abgelaufen ist.
var ErrAbbruch = errors.New("abgebrochen")

// AUFGABE 4.1
// Parallel ruft f für jede Zahl in einer eigenen Goroutine auf und
// gibt die Ergebnisse in der REIHENFOLGE DER EINGABE zurück.
// Warte, bis alle fertig sind. Kein Wettlauf -- der Prüfer läuft
// mit -race.
func Parallel(zahlen []int, f func(int) int) []int {
	return nil // TODO
}

// AUFGABE 4.2
// SummeAusKanal liest, bis der Kanal geschlossen wird, und gibt die
// Summe zurück.
func SummeAusKanal(c <-chan int) int {
	return 0 // TODO
}

// AUFGABE 4.3
// Erzeuge schickt die Zahlen 1..n in einen Kanal und schließt ihn
// danach. Die Funktion darf NICHT blockieren -- sie gibt den Kanal
// sofort zurück und füllt ihn nebenläufig.
func Erzeuge(n int) <-chan int {
	return nil // TODO
}

// AUFGABE 4.4
// MitFrist wartet auf das Ergebnis von f. Dauert es länger als der
// Context erlaubt, gibt es 0 und ErrAbbruch zurück -- ohne auf f zu
// warten.
func MitFrist(ctx context.Context, f func() int) (int, error) {
	return 0, nil // TODO
}

// Zaehler zählt Ereignisse aus mehreren Goroutinen.
type Zaehler struct {
	// TODO 4.5: was fehlt hier, damit gleichzeitige Zugriffe
	// sicher sind?
	wert int
}

// AUFGABE 4.5
// Hoch erhöht den Zähler um eins, auch wenn viele Goroutinen es
// gleichzeitig tun. Wert gibt den Stand zurück.
func (z *Zaehler) Hoch() {
	z.wert++ // TODO
}

func (z *Zaehler) Wert() int {
	return z.wert // TODO
}
