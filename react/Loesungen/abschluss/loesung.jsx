// Musterlösung zur Abschlussaufgabe.
import { useEffect, useState } from 'react';

export function Notizen({ laden }) {
  const [zustand, setZustand] = useState({ art: 'laedt' });
  const [notizen, setNotizen] = useState([]);
  const [titel, setTitel] = useState('');
  const [nurWichtige, setNurWichtige] = useState(false);

  useEffect(() => {
    let abgemeldet = false;
    laden()
      .then((daten) => {
        if (abgemeldet) return;
        setNotizen(daten);
        setZustand({ art: 'fertig' });
      })
      .catch((fehler) => {
        if (!abgemeldet) setZustand({ art: 'fehler', text: fehler.message });
      });
    return () => {
      abgemeldet = true;
    };
  }, [laden]);

  if (zustand.art === 'laedt') return <p>lädt…</p>;
  if (zustand.art === 'fehler') return <p>Fehler: {zustand.text}</p>;

  // Beides abgeleitet, nichts davon gehört in den Zustand.
  const wichtige = notizen.filter((n) => n.wichtig).length;
  const sichtbar = nurWichtige ? notizen.filter((n) => n.wichtig) : notizen;

  function anlegen(e) {
    e.preventDefault();
    const sauber = titel.trim();
    if (!sauber) return;
    setNotizen((alt) => [
      ...alt,
      { id: Date.now() + Math.random(), titel: sauber, wichtig: false },
    ]);
    setTitel('');
  }

  return (
    <div>
      <form onSubmit={anlegen}>
        <label htmlFor="titel">Titel</label>
        <input id="titel" value={titel} onChange={(e) => setTitel(e.target.value)} />
        <button type="submit">anlegen</button>
      </form>

      <button onClick={() => setNurWichtige((w) => !w)}>
        {nurWichtige ? 'alle zeigen' : 'nur wichtige'}
      </button>

      <ul>
        {sichtbar.map((n) => (
          <li key={n.id} className={n.wichtig ? 'wichtig' : undefined}>
            <label>
              <input
                type="checkbox"
                checked={n.wichtig}
                onChange={() =>
                  setNotizen((alt) =>
                    alt.map((x) => (x.id === n.id ? { ...x, wichtig: !x.wichtig } : x)),
                  )
                }
              />
              {n.titel}
            </label>
            <button onClick={() => setNotizen((alt) => alt.filter((x) => x.id !== n.id))}>
              löschen
            </button>
          </li>
        ))}
      </ul>

      <p data-testid="anzahl">
        {notizen.length} Notizen, {wichtige} wichtig
      </p>
    </div>
  );
}
