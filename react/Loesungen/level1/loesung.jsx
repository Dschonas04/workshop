// Musterlösung zu Level 1.

export function Gruss({ name }) {
  return <p>Hallo, {name}!</p>;
}

export function Preis({ betrag }) {
  return <span>{betrag.toFixed(2)} €</span>;
}

export function Kasten({ titel, children }) {
  return (
    <section>
      <h2>{titel}</h2>
      {children}
    </section>
  );
}

export function Zustand({ aktiv }) {
  return <span className={aktiv ? 'an' : 'aus'}>{aktiv ? 'online' : 'offline'}</span>;
}

export function Liste({ eintraege }) {
  return (
    <ul>
      {eintraege.map((e) => (
        <li key={e.id}>{e.name}</li>
      ))}
    </ul>
  );
}
