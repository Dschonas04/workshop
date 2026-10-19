// Musterlösung zu Level 2.
package level2

import "sort"

type Person struct {
	Name  string
	Alter int
}

func Summe(zahlen []int) int {
	summe := 0
	for _, z := range zahlen {
		summe += z
	}
	return summe
}

func NurGerade(zahlen []int) []int {
	gerade := []int{}
	for _, z := range zahlen {
		if z%2 == 0 {
			gerade = append(gerade, z)
		}
	}
	return gerade
}

func Zaehle(woerter []string) map[string]int {
	anzahl := make(map[string]int, len(woerter))
	for _, w := range woerter {
		anzahl[w]++
	}
	return anzahl
}

func Aelteste(leute []Person) (Person, bool) {
	if len(leute) == 0 {
		return Person{}, false
	}
	aelteste := leute[0]
	for _, p := range leute[1:] {
		if p.Alter > aelteste.Alter {
			aelteste = p
		}
	}
	return aelteste, true
}

// Zeiger-Empfänger: sonst bekäme die Methode eine Kopie, und der
// Geburtstag fände nur innerhalb der Methode statt.
func (p *Person) Geburtstag() {
	p.Alter++
}

func SortiertNachAlter(leute []Person) []string {
	kopie := make([]Person, len(leute))
	copy(kopie, leute)
	sort.Slice(kopie, func(i, j int) bool {
		if kopie[i].Alter != kopie[j].Alter {
			return kopie[i].Alter < kopie[j].Alter
		}
		return kopie[i].Name < kopie[j].Name
	})
	namen := make([]string, 0, len(kopie))
	for _, p := range kopie {
		namen = append(namen, p.Name)
	}
	return namen
}
