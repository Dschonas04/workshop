package level4

import (
	"context"
	"errors"
	"reflect"
	"sync"
	"testing"
	"time"
)

func TestParallel(t *testing.T) {
	ein := []int{1, 2, 3, 4}
	will := []int{1, 4, 9, 16}
	hat := Parallel(ein, func(n int) int { return n * n })
	if !reflect.DeepEqual(hat, will) {
		t.Errorf("Parallel = %v, erwartet %v (Reihenfolge zählt)", hat, will)
	}
	if hat := Parallel(nil, func(n int) int { return n }); len(hat) != 0 {
		t.Errorf("Parallel(nil) = %v, erwartet leer", hat)
	}
}

func TestSummeAusKanal(t *testing.T) {
	c := make(chan int, 3)
	c <- 1
	c <- 2
	c <- 3
	close(c)
	if hat := SummeAusKanal(c); hat != 6 {
		t.Errorf("SummeAusKanal = %d, erwartet 6", hat)
	}
}

func TestErzeuge(t *testing.T) {
	fertig := make(chan []int)
	go func() {
		var gesammelt []int
		for w := range Erzeuge(4) {
			gesammelt = append(gesammelt, w)
		}
		fertig <- gesammelt
	}()
	select {
	case hat := <-fertig:
		will := []int{1, 2, 3, 4}
		if !reflect.DeepEqual(hat, will) {
			t.Errorf("Erzeuge(4) lieferte %v, erwartet %v", hat, will)
		}
	case <-time.After(2 * time.Second):
		t.Fatal("Erzeuge hat den Kanal nicht geschlossen oder blockiert")
	}
}

func TestMitFrist(t *testing.T) {
	ctx := context.Background()
	if hat, err := MitFrist(ctx, func() int { return 7 }); err != nil || hat != 7 {
		t.Errorf("MitFrist ohne Frist = %d, %v; erwartet 7, nil", hat, err)
	}

	kurz, abbrechen := context.WithTimeout(context.Background(), 50*time.Millisecond)
	defer abbrechen()
	start := time.Now()
	_, err := MitFrist(kurz, func() int {
		time.Sleep(2 * time.Second)
		return 1
	})
	if !errors.Is(err, ErrAbbruch) {
		t.Errorf("MitFrist gab %v, erwartet ErrAbbruch", err)
	}
	if time.Since(start) > time.Second {
		t.Error("MitFrist hat auf f gewartet, statt bei Fristablauf zurückzukehren")
	}
}

func TestZaehler(t *testing.T) {
	var z Zaehler
	var wg sync.WaitGroup
	for i := 0; i < 200; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			z.Hoch()
		}()
	}
	wg.Wait()
	if z.Wert() != 200 {
		t.Errorf("Zaehler = %d, erwartet 200", z.Wert())
	}
}
