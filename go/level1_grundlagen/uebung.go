// Package level1 -- deine Übung zu Level 1.
//
// Die Aufgabenstellung steht in Aufgabenstellung.txt.
//
// Fülle die Funktionen aus. Prüfen mit:  ./pruefen.sh 1
package level1

import "errors"

// ErrTeilenDurchNull wird von Teile zurückgegeben, wenn der Teiler 0 ist.
var ErrTeilenDurchNull = errors.New("Division durch null")

// AUFGABE 1.1
// Addiere gibt die Summe von a und b zurück.
func Addiere(a, b int) int {
	return 0 // TODO
}

// AUFGABE 1.2
// Teile gibt a/b zurück. Ist b gleich 0, gibt es 0 und
// ErrTeilenDurchNull zurück.
func Teile(a, b float64) (float64, error) {
	return 0, nil // TODO
}

// AUFGABE 1.3
// Groesster gibt den größten Wert der Liste zurück und true.
// Bei einer leeren Liste gibt es 0 und false zurück.
func Groesster(zahlen []int) (int, bool) {
	return 0, false // TODO
}

// AUFGABE 1.4
// Fizz gibt für Vielfache von 3 "Fizz", für Vielfache von 5 "Buzz",
// für Vielfache von beidem "FizzBuzz" und sonst die Zahl als Text
// zurück. Nutze strconv.Itoa für die Zahl.
func Fizz(n int) string {
	return "" // TODO
}

// AUFGABE 1.5
// Wiederhole hängt text n-mal aneinander. Bei n <= 0 ist das
// Ergebnis leer. Nutze eine Schleife und einen strings.Builder.
func Wiederhole(text string, n int) string {
	return "" // TODO
}
