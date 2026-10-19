// Musterlösung zu Level 3.
import { useState } from 'react';

export function NeuerEintrag({ onHinzufuegen }) {
  const [text, setText] = useState('');

  function absenden(e) {
    // Ohne das lädt der Browser die Seite neu.
    e.preventDefault();
    const sauber = text.trim();
    if (!sauber) return;
    onHinzufuegen(sauber);
    setText('');
  }

  return (
    <form onSubmit={absenden}>
      <label htmlFor="neue-aufgabe">Aufgabe</label>
      <input id="neue-aufgabe" value={text} onChange={(e) => setText(e.target.value)} />
      <button type="submit">hinzufügen</button>
    </form>
  );
}

export function Aufgabenliste({ anfang = [] }) {
  const [liste, setListe] = useState(anfang);
  const offen = liste.filter((e) => !e.erledigt).length;

  function hinzufuegen(text) {
    setListe((alt) => [...alt, { id: Date.now() + Math.random(), text, erledigt: false }]);
  }

  function umschalten(id) {
    setListe((alt) => alt.map((e) => (e.id === id ? { ...e, erledigt: !e.erledigt } : e)));
  }

  function loeschen(id) {
    setListe((alt) => alt.filter((e) => e.id !== id));
  }

  return (
    <div>
      <NeuerEintrag onHinzufuegen={hinzufuegen} />
      <ul>
        {liste.map((e) => (
          <li key={e.id} className={e.erledigt ? 'erledigt' : undefined}>
            <label>
              <input
                type="checkbox"
                checked={e.erledigt}
                onChange={() => umschalten(e.id)}
              />
              {e.text}
            </label>
            <button onClick={() => loeschen(e.id)}>löschen</button>
          </li>
        ))}
      </ul>
      <p data-testid="offen">{offen} offen</p>
    </div>
  );
}
