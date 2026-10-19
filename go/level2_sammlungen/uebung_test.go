package level2

import (
	"reflect"
	"testing"
)

func TestSumme(t *testing.T) {
	if hat := Summe([]int{1, 2, 3}); hat != 6 {
		t.Errorf("Summe([1 2 3]) = %d, erwartet 6", hat)
	}
	if hat := Summe(nil); hat != 0 {
		t.Errorf("Summe(nil) = %d, erwartet 0", hat)
	}
}

func TestNurGerade(t *testing.T) {
	ein := []int{1, 2, 3, 4, 6}
	will := []int{2, 4, 6}
	hat := NurGerade(ein)
	if !reflect.DeepEqual(hat, will) {
		t.Errorf("NurGerade(%v) = %v, erwartet %v", ein, hat, will)
	}
	if !reflect.DeepEqual(ein, []int{1, 2, 3, 4, 6}) {
		t.Errorf("die Eingabe wurde verändert: %v", ein)
	}
}

func TestZaehle(t *testing.T) {
	hat := Zaehle([]string{"a", "b", "a"})
	will := map[string]int{"a": 2, "b": 1}
	if !reflect.DeepEqual(hat, will) {
		t.Errorf("Zaehle = %v, erwartet %v", hat, will)
	}
	if leer := Zaehle(nil); len(leer) != 0 {
		t.Errorf("Zaehle(nil) = %v, erwartet leer", leer)
	}
}

func TestAelteste(t *testing.T) {
	leute := []Person{{"Anna", 30}, {"Bert", 45}, {"Carla", 28}}
	hat, ok := Aelteste(leute)
	if !ok || hat.Name != "Bert" {
		t.Errorf("Aelteste = %v, %v; erwartet Bert, true", hat, ok)
	}
	if _, ok := Aelteste(nil); ok {
		t.Error("Aelteste(nil) meldete true")
	}
}

func TestGeburtstag(t *testing.T) {
	p := Person{Name: "Anna", Alter: 30}
	p.Geburtstag()
	if p.Alter != 31 {
		t.Errorf("nach Geburtstag ist das Alter %d, erwartet 31 -- "+
			"kommt die Änderung beim Aufrufer an?", p.Alter)
	}
}

func TestSortiertNachAlter(t *testing.T) {
	leute := []Person{{"Bert", 45}, {"Anna", 30}, {"Carla", 30}}
	will := []string{"Anna", "Carla", "Bert"}
	if hat := SortiertNachAlter(leute); !reflect.DeepEqual(hat, will) {
		t.Errorf("SortiertNachAlter = %v, erwartet %v", hat, will)
	}
}
