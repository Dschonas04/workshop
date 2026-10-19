// Musterlösung zur Abschlussaufgabe.
package abschluss

import (
	"context"
	"errors"
	"sort"
	"strings"
	"sync"
	"unicode"
)

var ErrAbbruch = errors.New("abgebrochen")

type Quelle interface {
	Name() string
	Text() (string, error)
}

type QuellFehler struct {
	Quelle string
	Grund  error
}

func (e *QuellFehler) Error() string { return "Quelle " + e.Quelle + ": " + e.Grund.Error() }
func (e *QuellFehler) Unwrap() error { return e.Grund }

func Zaehle(text string) map[string]int {
	anzahl := map[string]int{}
	for _, roh := range strings.Fields(text) {
		wort := strings.ToLower(strings.TrimFunc(roh, func(r rune) bool {
			return !unicode.IsLetter(r) && !unicode.IsDigit(r)
		}))
		if wort == "" {
			continue
		}
		anzahl[wort]++
	}
	return anzahl
}

func Haeufigste(anzahl map[string]int, n int) []string {
	woerter := make([]string, 0, len(anzahl))
	for w := range anzahl {
		woerter = append(woerter, w)
	}
	sort.Slice(woerter, func(i, j int) bool {
		if anzahl[woerter[i]] != anzahl[woerter[j]] {
			return anzahl[woerter[i]] > anzahl[woerter[j]]
		}
		return woerter[i] < woerter[j]
	})
	if n > len(woerter) {
		n = len(woerter)
	}
	return woerter[:n]
}

func ZaehleQuellen(ctx context.Context, quellen []Quelle) (map[string]int, error) {
	type ergebnis struct {
		anzahl map[string]int
		err    error
	}
	// Gepuffert in voller Größe: so endet jede Goroutine, auch wenn
	// wir wegen des Contexts früher zurückkehren.
	fertig := make(chan ergebnis, len(quellen))

	var wg sync.WaitGroup
	for _, q := range quellen {
		wg.Add(1)
		go func(q Quelle) {
			defer wg.Done()
			text, err := q.Text()
			if err != nil {
				fertig <- ergebnis{err: &QuellFehler{Quelle: q.Name(), Grund: err}}
				return
			}
			fertig <- ergebnis{anzahl: Zaehle(text)}
		}(q)
	}
	go func() {
		wg.Wait()
		close(fertig)
	}()

	gesamt := map[string]int{}
	for i := 0; i < len(quellen); i++ {
		select {
		case e := <-fertig:
			if e.err != nil {
				return nil, e.err
			}
			for w, n := range e.anzahl {
				gesamt[w] += n
			}
		case <-ctx.Done():
			return nil, ErrAbbruch
		}
	}
	return gesamt, nil
}
