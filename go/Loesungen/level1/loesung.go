// Musterlösung zu Level 1.
package level1

import (
	"errors"
	"strconv"
	"strings"
)

var ErrTeilenDurchNull = errors.New("Division durch null")

func Addiere(a, b int) int {
	return a + b
}

func Teile(a, b float64) (float64, error) {
	if b == 0 {
		return 0, ErrTeilenDurchNull
	}
	return a / b, nil
}

func Groesster(zahlen []int) (int, bool) {
	if len(zahlen) == 0 {
		return 0, false
	}
	groesster := zahlen[0]
	for _, z := range zahlen[1:] {
		if z > groesster {
			groesster = z
		}
	}
	return groesster, true
}

func Fizz(n int) string {
	switch {
	case n%15 == 0:
		return "FizzBuzz"
	case n%3 == 0:
		return "Fizz"
	case n%5 == 0:
		return "Buzz"
	default:
		return strconv.Itoa(n)
	}
}

func Wiederhole(text string, n int) string {
	var b strings.Builder
	for i := 0; i < n; i++ {
		b.WriteString(text)
	}
	return b.String()
}
