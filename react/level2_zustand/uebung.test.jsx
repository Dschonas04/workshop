import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, test } from 'vitest';

import { DoppelKlick, Eingabe, Schalter, Warenkorb, Zaehler } from './uebung.jsx';

describe('Level 2', () => {
  test('2.1 Zaehler zählt hoch und runter', async () => {
    const nutzer = userEvent.setup();
    render(<Zaehler start={5} />);
    expect(screen.getByText('5')).toBeInTheDocument();

    await nutzer.click(screen.getByRole('button', { name: 'mehr' }));
    expect(screen.getByText('6')).toBeInTheDocument();

    await nutzer.click(screen.getByRole('button', { name: 'weniger' }));
    await nutzer.click(screen.getByRole('button', { name: 'weniger' }));
    expect(screen.getByText('4')).toBeInTheDocument();
  });

  test('2.2 zwei Aufrufe erhöhen um zwei', async () => {
    const nutzer = userEvent.setup();
    render(<DoppelKlick />);
    await nutzer.click(screen.getByRole('button', { name: 'zweimal' }));
    expect(screen.getByText('2')).toBeInTheDocument();
  });

  test('2.3 kontrolliertes Feld zählt die Zeichen', async () => {
    const nutzer = userEvent.setup();
    render(<Eingabe />);
    const feld = screen.getByRole('textbox');
    await nutzer.type(feld, 'Hallo');
    expect(feld).toHaveValue('Hallo');
    expect(screen.getByText('5 Zeichen')).toBeInTheDocument();
  });

  test('2.4 Schalter wechselt die Beschriftung', async () => {
    const nutzer = userEvent.setup();
    render(<Schalter />);
    const knopf = screen.getByRole('button', { name: 'aus' });
    await nutzer.click(knopf);
    expect(screen.getByRole('button', { name: 'an' })).toBeInTheDocument();
    await nutzer.click(screen.getByRole('button', { name: 'an' }));
    expect(screen.getByRole('button', { name: 'aus' })).toBeInTheDocument();
  });

  test('2.5 Warenkorb rechnet die Summe aus', () => {
    render(
      <Warenkorb
        artikel={[
          { id: 1, name: 'Buch', preis: 12.5 },
          { id: 2, name: 'Stift', preis: 2.25 },
        ]}
      />,
    );
    expect(screen.getByText('Buch')).toBeInTheDocument();
    expect(screen.getByTestId('summe')).toHaveTextContent('14.75 €');
  });
});
