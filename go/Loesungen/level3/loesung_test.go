package level3

import (
	"errors"
	"fmt"
	"math"
	"testing"
)

func TestFormenErfuellenFormer(t *testing.T) {
	var _ Former = Kreis{}
	var _ Former = Rechteck{}
}

func TestFlaeche(t *testing.T) {
	if hat := (Kreis{R: 2}).Flaeche(); math.Abs(hat-12.566370) > 0.001 {
		t.Errorf("Kreis{2}.Flaeche() = %v, erwartet etwa 12.5664", hat)
	}
	if hat := (Rechteck{B: 3, H: 4}).Flaeche(); hat != 12 {
		t.Errorf("Rechteck{3,4}.Flaeche() = %v, erwartet 12", hat)
	}
}

func TestGesamtflaeche(t *testing.T) {
	hat, err := Gesamtflaeche([]Former{Rechteck{B: 2, H: 3}, Rechteck{B: 1, H: 4}})
	if err != nil {
		t.Fatalf("unerwarteter Fehler: %v", err)
	}
	if hat != 10 {
		t.Errorf("Gesamtflaeche = %v, erwartet 10", hat)
	}
	if _, err := Gesamtflaeche(nil); !errors.Is(err, ErrLeer) {
		t.Errorf("Gesamtflaeche(nil) gab %v, erwartet ErrLeer", err)
	}
}

func TestPruefeUndFehlertext(t *testing.T) {
	if err := Pruefe("name", "Anna"); err != nil {
		t.Errorf("Pruefe(name, Anna) gab %v, erwartet nil", err)
	}
	err := Pruefe("name", "ab")
	if err == nil {
		t.Fatal("Pruefe(name, ab) gab keinen Fehler")
	}
	if err.Error() != "Feld name: zu kurz" {
		t.Errorf("Fehlertext = %q, erwartet \"Feld name: zu kurz\"", err.Error())
	}
	if !errors.Is(err, ErrZuKurz) {
		t.Error("errors.Is findet ErrZuKurz nicht -- fehlt Unwrap?")
	}
}

func TestFeldVonFehler(t *testing.T) {
	err := Pruefe("plz", "1")
	verpackt := fmt.Errorf("beim Speichern: %w", err)

	if feld, ok := FeldVonFehler(verpackt); !ok || feld != "plz" {
		t.Errorf("FeldVonFehler = %q, %v; erwartet plz, true", feld, ok)
	}
	if _, ok := FeldVonFehler(errors.New("etwas anderes")); ok {
		t.Error("FeldVonFehler meldete true für einen fremden Fehler")
	}
}
