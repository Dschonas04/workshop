// ================================================================
//  Deine Übung zu Level 2: Zustand und Ereignisse 
//  Die Aufgabenstellung steht in Aufgabenstellung.txt.
//  Prüfen mit:  ./pruefen.sh 2
// ================================================================
import { useState } from 'react';

// AUFGABE 2.1 -- siehe Aufgabenstellung.txt
export function Zaehler({ start = 0 }) {
  return null; // TODO
}

// AUFGABE 2.2 -- siehe Aufgabenstellung.txt
export function DoppelKlick() {
  const [stand, setStand] = useState(0);
  return (
    <div>
      <output>{stand}</output>
      <button onClick={() => { /* TODO */ }}>zweimal</button>
    </div>
  );
}

// AUFGABE 2.3 -- siehe Aufgabenstellung.txt
export function Eingabe() {
  return null; // TODO
}

// AUFGABE 2.4 -- siehe Aufgabenstellung.txt
export function Schalter() {
  return null; // TODO
}

// AUFGABE 2.5 -- siehe Aufgabenstellung.txt
export function Warenkorb({ artikel }) {
  return null; // TODO
}
