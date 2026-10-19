// Musterlösung zu Level 2.
import { useState } from 'react';

export function Zaehler({ start = 0 }) {
  const [stand, setStand] = useState(start);
  return (
    <div>
      <output>{stand}</output>
      <button onClick={() => setStand((s) => s + 1)}>mehr</button>
      <button onClick={() => setStand((s) => s - 1)}>weniger</button>
    </div>
  );
}

export function DoppelKlick() {
  const [stand, setStand] = useState(0);
  return (
    <div>
      <output>{stand}</output>
      <button
        onClick={() => {
          // Mit dem alten Wert gerechnet ergäbe zweimal dasselbe.
          setStand((s) => s + 1);
          setStand((s) => s + 1);
        }}
      >
        zweimal
      </button>
    </div>
  );
}

export function Eingabe() {
  const [text, setText] = useState('');
  return (
    <div>
      <input value={text} onChange={(e) => setText(e.target.value)} />
      <p>{text.length} Zeichen</p>
    </div>
  );
}

export function Schalter() {
  const [an, setAn] = useState(false);
  return <button onClick={() => setAn((a) => !a)}>{an ? 'an' : 'aus'}</button>;
}

export function Warenkorb({ artikel }) {
  // Abgeleitet, nicht gespeichert.
  const summe = artikel.reduce((s, a) => s + a.preis, 0);
  return (
    <div>
      <ul>
        {artikel.map((a) => (
          <li key={a.id}>{a.name}</li>
        ))}
      </ul>
      <p data-testid="summe">{summe.toFixed(2)} €</p>
    </div>
  );
}
