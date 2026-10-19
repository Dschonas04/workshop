import { act, render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, test } from 'vitest';

import { Notizen } from './loesung.jsx';

const anfang = [
  { id: 1, titel: 'Einkaufen', wichtig: false },
  { id: 2, titel: 'Steuer', wichtig: true },
];

function ladenMit(daten) {
  return () => Promise.resolve(daten.map((d) => ({ ...d })));
}

async function zeichnen(daten = anfang) {
  const ergebnis = render(<Notizen laden={ladenMit(daten)} />);
  await act(async () => {});
  return ergebnis;
}

describe('Abschluss', () => {
  test('zeigt zuerst den Ladezustand', () => {
    render(<Notizen laden={() => new Promise(() => {})} />);
    expect(screen.getByText('lädt…')).toBeInTheDocument();
  });

  test('meldet einen Fehler', async () => {
    render(<Notizen laden={() => Promise.reject(new Error('kaputt'))} />);
    await act(async () => {});
    expect(screen.getByText('Fehler: kaputt')).toBeInTheDocument();
  });

  test('zeigt die geladenen Notizen und die Zählung', async () => {
    await zeichnen();
    expect(screen.getAllByRole('listitem')).toHaveLength(2);
    expect(screen.getByTestId('anzahl')).toHaveTextContent('2 Notizen, 1 wichtig');
  });

  test('markiert wichtige Notizen', async () => {
    await zeichnen();
    const zeilen = screen.getAllByRole('listitem');
    expect(zeilen[1]).toHaveClass('wichtig');
    expect(zeilen[0]).not.toHaveClass('wichtig');
  });

  test('legt eine Notiz an', async () => {
    const nutzer = userEvent.setup();
    await zeichnen();
    await nutzer.type(screen.getByLabelText('Titel'), '  Zahnarzt  ');
    await nutzer.click(screen.getByRole('button', { name: 'anlegen' }));

    const zeilen = screen.getAllByRole('listitem');
    expect(zeilen).toHaveLength(3);
    expect(zeilen[2]).toHaveTextContent('Zahnarzt');
    expect(screen.getByLabelText('Titel')).toHaveValue('');
    expect(screen.getByTestId('anzahl')).toHaveTextContent('3 Notizen, 1 wichtig');
  });

  test('legt keine leere Notiz an', async () => {
    const nutzer = userEvent.setup();
    await zeichnen();
    await nutzer.click(screen.getByRole('button', { name: 'anlegen' }));
    expect(screen.getAllByRole('listitem')).toHaveLength(2);
  });

  test('schaltet wichtig um', async () => {
    const nutzer = userEvent.setup();
    await zeichnen();
    await nutzer.click(screen.getByLabelText('Einkaufen'));
    expect(screen.getByTestId('anzahl')).toHaveTextContent('2 Notizen, 2 wichtig');
  });

  test('löscht die richtige Notiz', async () => {
    const nutzer = userEvent.setup();
    await zeichnen();
    const erste = screen.getAllByRole('listitem')[0];
    await nutzer.click(within(erste).getByRole('button', { name: 'löschen' }));
    const uebrig = screen.getAllByRole('listitem');
    expect(uebrig).toHaveLength(1);
    expect(uebrig[0]).toHaveTextContent('Steuer');
  });

  test('filtert auf wichtige und zurück', async () => {
    const nutzer = userEvent.setup();
    await zeichnen();
    await nutzer.click(screen.getByRole('button', { name: 'nur wichtige' }));
    expect(screen.getAllByRole('listitem')).toHaveLength(1);
    expect(screen.getByTestId('anzahl')).toHaveTextContent('2 Notizen, 1 wichtig');

    await nutzer.click(screen.getByRole('button', { name: 'alle zeigen' }));
    expect(screen.getAllByRole('listitem')).toHaveLength(2);
  });
});
