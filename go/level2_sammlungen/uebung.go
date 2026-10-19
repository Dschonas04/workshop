// Package level2 -- deine Übung zu Level 2.
//
// Die Aufgabenstellung steht in Aufgabenstellung.txt.
package level2

// Person ist ein einfacher Datensatz.
type Person struct {
	Name  string
	Alter int
}

// AUFGABE 2.1
// Summe addiert alle Zahlen. Eine leere Liste ergibt 0.
func Summe(zahlen []int) int {
	return 0 // TODO
}

// AUFGABE 2.2
// NurGerade gibt eine neue Liste mit den geraden Zahlen zurück,
// in der ursprünglichen Reihenfolge. Die Eingabe bleibt unberührt.
func NurGerade(zahlen []int) []int {
	return nil // TODO
}

// AUFGABE 2.3
// Zaehle zählt, wie oft jedes Wort vorkommt.
// Aus ["a","b","a"] wird {"a":2, "b":1}.
func Zaehle(woerter []string) map[string]int {
	return nil // TODO
}

// AUFGABE 2.4
// Aelteste gibt die älteste Person zurück und true.
// Bei einer leeren Liste die Nullperson und false.
func Aelteste(leute []Person) (Person, bool) {
	return Person{}, false // TODO
}

// AUFGABE 2.5
// Geburtstag erhöht das Alter der Person um eins.
// Achtung: das muss beim Aufrufer ankommen.
func (p Person) Geburtstag() {
	// TODO
}

// AUFGABE 2.6
// SortiertNachAlter gibt die Namen zurück, aufsteigend nach Alter.
// Bei gleichem Alter alphabetisch nach Namen.
func SortiertNachAlter(leute []Person) []string {
	return nil // TODO
}
