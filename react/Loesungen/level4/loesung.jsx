// Musterlösung zu Level 4.
import { useEffect, useState } from 'react';

export function useSchalter(anfang = false) {
  const [an, setAn] = useState(anfang);
  return [an, () => setAn((a) => !a)];
}

export function Titel({ anzahl }) {
  useEffect(() => {
    document.title = `${anzahl} offen`;
  }, [anzahl]);
  return <p>{anzahl} offen</p>;
}

export function Uhr() {
  const [stand, setStand] = useState(0);
  useEffect(() => {
    const id = setInterval(() => setStand((s) => s + 1), 50);
    // Ohne das Aufräumen liefe nach jedem Einhängen ein weiterer
    // Zeitgeber -- und nach dem Aushängen schriebe er ins Leere.
    return () => clearInterval(id);
  }, []);
  return <output>{stand}</output>;
}

export function Laden({ hole }) {
  const [zustand, setZustand] = useState({ art: 'laedt' });

  useEffect(() => {
    let abgemeldet = false;
    hole()
      .then((text) => {
        if (!abgemeldet) setZustand({ art: 'fertig', text });
      })
      .catch((fehler) => {
        if (!abgemeldet) setZustand({ art: 'fehler', text: fehler.message });
      });
    return () => {
      abgemeldet = true;
    };
  }, [hole]);

  if (zustand.art === 'laedt') return <p>lädt…</p>;
  if (zustand.art === 'fehler') return <p>Fehler: {zustand.text}</p>;
  return <p>{zustand.text}</p>;
}
