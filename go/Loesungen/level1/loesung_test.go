package level1

import (
	"errors"
	"testing"
)

func TestAddiere(t *testing.T) {
	faelle := []struct {
		a, b, will int
	}{
		{2, 3, 5},
		{-1, 1, 0},
		{0, 0, 0},
	}
	for _, f := range faelle {
		if hat := Addiere(f.a, f.b); hat != f.will {
			t.Errorf("Addiere(%d, %d) = %d, erwartet %d", f.a, f.b, hat, f.will)
		}
	}
}

func TestTeile(t *testing.T) {
	hat, err := Teile(10, 4)
	if err != nil {
		t.Fatalf("Teile(10, 4) gab einen Fehler: %v", err)
	}
	if hat != 2.5 {
		t.Errorf("Teile(10, 4) = %v, erwartet 2.5", hat)
	}

	_, err = Teile(1, 0)
	if err == nil {
		t.Fatal("Teile(1, 0) gab keinen Fehler")
	}
	if !errors.Is(err, ErrTeilenDurchNull) {
		t.Errorf("Teile(1, 0) gab %v, erwartet ErrTeilenDurchNull", err)
	}
}

func TestGroesster(t *testing.T) {
	if hat, ok := Groesster([]int{3, 9, 2}); hat != 9 || !ok {
		t.Errorf("Groesster([3 9 2]) = %d, %v; erwartet 9, true", hat, ok)
	}
	if hat, ok := Groesster(nil); hat != 0 || ok {
		t.Errorf("Groesster(nil) = %d, %v; erwartet 0, false", hat, ok)
	}
}

func TestFizz(t *testing.T) {
	faelle := map[int]string{1: "1", 3: "Fizz", 5: "Buzz", 15: "FizzBuzz", 7: "7"}
	for n, will := range faelle {
		if hat := Fizz(n); hat != will {
			t.Errorf("Fizz(%d) = %q, erwartet %q", n, hat, will)
		}
	}
}

func TestWiederhole(t *testing.T) {
	if hat := Wiederhole("ab", 3); hat != "ababab" {
		t.Errorf("Wiederhole(\"ab\", 3) = %q, erwartet \"ababab\"", hat)
	}
	if hat := Wiederhole("ab", 0); hat != "" {
		t.Errorf("Wiederhole(\"ab\", 0) = %q, erwartet \"\"", hat)
	}
}
