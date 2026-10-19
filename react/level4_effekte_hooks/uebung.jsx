// ================================================================
//  Deine Übung zu Level 4: Effekte und eigene Hooks 
//  Die Aufgabenstellung steht in Aufgabenstellung.txt.
//  Prüfen mit:  ./pruefen.sh 4
// ================================================================
import { useEffect, useState } from 'react';

// AUFGABE 4.1 -- siehe Aufgabenstellung.txt
export function useSchalter(anfang = false) {
  return [false, () => {}]; // TODO
}

// AUFGABE 4.2 -- siehe Aufgabenstellung.txt
export function Titel({ anzahl }) {
  // TODO
  return <p>{anzahl} offen</p>;
}

// AUFGABE 4.3 -- siehe Aufgabenstellung.txt
export function Uhr() {
  const [stand, setStand] = useState(0);
  // TODO
  return <output>{stand}</output>;
}

// AUFGABE 4.4 -- siehe Aufgabenstellung.txt
export function Laden({ hole }) {
  return null; // TODO
}
