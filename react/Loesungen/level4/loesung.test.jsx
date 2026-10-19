import { act, render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { afterEach, describe, expect, test, vi } from 'vitest';

import { Laden, Titel, Uhr, useSchalter } from './loesung.jsx';

// Eine kleine Komponente, um den Hook zu prüfen.
function SchalterProbe() {
  const [an, umschalten] = useSchalter(false);
  return <button onClick={umschalten}>{an ? 'an' : 'aus'}</button>;
}

afterEach(() => {
  vi.useRealTimers();
});

describe('Level 4', () => {
  test('4.1 eigener Hook schaltet um', async () => {
    const nutzer = userEvent.setup();
    render(<SchalterProbe />);
    await nutzer.click(screen.getByRole('button', { name: 'aus' }));
    expect(screen.getByRole('button', { name: 'an' })).toBeInTheDocument();
  });

  test('4.1 zwei Komponenten haben je eigenen Zustand', async () => {
    const nutzer = userEvent.setup();
    render(
      <>
        <SchalterProbe />
        <SchalterProbe />
      </>,
    );
    const knoepfe = screen.getAllByRole('button');
    await nutzer.click(knoepfe[0]);
    expect(knoepfe[0]).toHaveTextContent('an');
    expect(knoepfe[1]).toHaveTextContent('aus');
  });

  test('4.2 Effekt setzt den Dokumententitel', () => {
    const { rerender } = render(<Titel anzahl={3} />);
    expect(document.title).toBe('3 offen');
    rerender(<Titel anzahl={7} />);
    expect(document.title).toBe('7 offen');
  });

  test('4.3 Uhr zählt und hört beim Aushängen auf', () => {
    vi.useFakeTimers();
    const { unmount } = render(<Uhr />);
    act(() => {
      vi.advanceTimersByTime(150);
    });
    expect(Number(screen.getByRole('status').textContent)).toBeGreaterThanOrEqual(2);

    unmount();
    // Nach dem Aushängen darf kein Zeitgeber mehr laufen.
    expect(vi.getTimerCount()).toBe(0);
  });

  test('4.4 Laden zeigt Warten, dann das Ergebnis', async () => {
    let aufloesen;
    const hole = () => new Promise((r) => { aufloesen = r; });
    render(<Laden hole={hole} />);

    expect(screen.getByText('lädt…')).toBeInTheDocument();
    await act(async () => {
      aufloesen('fertig geladen');
    });
    expect(screen.getByText('fertig geladen')).toBeInTheDocument();
  });

  test('4.4 Laden zeigt Fehler', async () => {
    const hole = () => Promise.reject(new Error('kaputt'));
    render(<Laden hole={hole} />);
    await act(async () => {});
    expect(screen.getByText('Fehler: kaputt')).toBeInTheDocument();
  });
});
