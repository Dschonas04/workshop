package abschluss

import (
	"context"
	"errors"
	"reflect"
	"testing"
	"time"
)

type festeQuelle struct {
	name string
	text string
	err  error
	warte time.Duration
}

func (q festeQuelle) Name() string { return q.name }
func (q festeQuelle) Text() (string, error) {
	if q.warte > 0 {
		time.Sleep(q.warte)
	}
	return q.text, q.err
}

func TestZaehle(t *testing.T) {
	hat := Zaehle("Der Hund und der Hund, im Haus.")
	will := map[string]int{"der": 2, "hund": 2, "und": 1, "im": 1, "haus": 1}
	if !reflect.DeepEqual(hat, will) {
		t.Errorf("Zaehle = %v, erwartet %v", hat, will)
	}
	if leer := Zaehle("   "); len(leer) != 0 {
		t.Errorf("Zaehle(Leerraum) = %v, erwartet leer", leer)
	}
}

func TestHaeufigste(t *testing.T) {
	anzahl := map[string]int{"der": 5, "hund": 5, "und": 3, "im": 1}
	if hat := Haeufigste(anzahl, 3); !reflect.DeepEqual(hat, []string{"der", "hund", "und"}) {
		t.Errorf("Haeufigste(3) = %v, erwartet [der hund und]", hat)
	}
	if hat := Haeufigste(anzahl, 10); len(hat) != 4 {
		t.Errorf("Haeufigste(10) gab %d Wörter, erwartet 4", len(hat))
	}
	if hat := Haeufigste(nil, 3); len(hat) != 0 {
		t.Errorf("Haeufigste(nil) = %v, erwartet leer", hat)
	}
}

func TestZaehleQuellen(t *testing.T) {
	quellen := []Quelle{
		festeQuelle{name: "a", text: "Hund Katze"},
		festeQuelle{name: "b", text: "hund maus"},
	}
	hat, err := ZaehleQuellen(context.Background(), quellen)
	if err != nil {
		t.Fatalf("unerwarteter Fehler: %v", err)
	}
	will := map[string]int{"hund": 2, "katze": 1, "maus": 1}
	if !reflect.DeepEqual(hat, will) {
		t.Errorf("ZaehleQuellen = %v, erwartet %v", hat, will)
	}
}

var errKaputt = errors.New("Quelle kaputt")

func TestQuellFehler(t *testing.T) {
	quellen := []Quelle{
		festeQuelle{name: "gut", text: "hund"},
		festeQuelle{name: "schlecht", err: errKaputt},
	}
	_, err := ZaehleQuellen(context.Background(), quellen)
	if err == nil {
		t.Fatal("kein Fehler, obwohl eine Quelle versagte")
	}
	if !errors.Is(err, errKaputt) {
		t.Errorf("errors.Is findet den Grund nicht: %v -- fehlt Unwrap?", err)
	}
	var qf *QuellFehler
	if !errors.As(err, &qf) || qf.Quelle != "schlecht" {
		t.Errorf("errors.As gab %v, erwartet QuellFehler für \"schlecht\"", err)
	}
}

func TestZaehleQuellenFrist(t *testing.T) {
	ctx, abbrechen := context.WithTimeout(context.Background(), 50*time.Millisecond)
	defer abbrechen()
	start := time.Now()
	_, err := ZaehleQuellen(ctx, []Quelle{
		festeQuelle{name: "langsam", text: "hund", warte: 3 * time.Second},
	})
	if !errors.Is(err, ErrAbbruch) {
		t.Errorf("ZaehleQuellen gab %v, erwartet ErrAbbruch", err)
	}
	if time.Since(start) > 2*time.Second {
		t.Error("ZaehleQuellen wartete auf die langsame Quelle")
	}
}
