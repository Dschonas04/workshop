// Musterlösung zu Level 4.
package level4

import (
	"context"
	"errors"
	"sync"
)

var ErrAbbruch = errors.New("abgebrochen")

func Parallel(zahlen []int, f func(int) int) []int {
	ergebnis := make([]int, len(zahlen))
	var wg sync.WaitGroup
	for i, z := range zahlen {
		wg.Add(1)
		go func(i, z int) {
			defer wg.Done()
			// Jede Goroutine schreibt an ihren eigenen Platz --
			// deshalb braucht es hier keine Sperre.
			ergebnis[i] = f(z)
		}(i, z)
	}
	wg.Wait()
	return ergebnis
}

func SummeAusKanal(c <-chan int) int {
	summe := 0
	for w := range c {
		summe += w
	}
	return summe
}

func Erzeuge(n int) <-chan int {
	c := make(chan int)
	go func() {
		defer close(c)
		for i := 1; i <= n; i++ {
			c <- i
		}
	}()
	return c
}

func MitFrist(ctx context.Context, f func() int) (int, error) {
	// Gepuffert, damit die Goroutine auch dann endet, wenn niemand
	// mehr liest -- sonst bliebe sie für immer stehen.
	fertig := make(chan int, 1)
	go func() { fertig <- f() }()

	select {
	case wert := <-fertig:
		return wert, nil
	case <-ctx.Done():
		return 0, ErrAbbruch
	}
}

type Zaehler struct {
	mu   sync.Mutex
	wert int
}

func (z *Zaehler) Hoch() {
	z.mu.Lock()
	defer z.mu.Unlock()
	z.wert++
}

func (z *Zaehler) Wert() int {
	z.mu.Lock()
	defer z.mu.Unlock()
	return z.wert
}
