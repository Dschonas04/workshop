import { render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, test, vi } from 'vitest';

import { Aufgabenliste, NeuerEintrag } from './uebung.jsx';

describe('Level 3', () => {
  test('3.1 Formular meldet den Text nach oben und leert sich', async () => {
    const nutzer = userEvent.setup();
    const gemeldet = vi.fn();
    render(<NeuerEintrag onHinzufuegen={gemeldet} />);

    const feld = screen.getByLabelText('Aufgabe');
    await nutzer.type(feld, '  Einkaufen  ');
    await nutzer.click(screen.getByRole('button', { name: 'hinzufügen' }));

    expect(gemeldet).toHaveBeenCalledWith('Einkaufen');
    expect(feld).toHaveValue('');
  });

  test('3.1 leere Eingabe wird nicht gemeldet', async () => {
    const nutzer = userEvent.setup();
    const gemeldet = vi.fn();
    render(<NeuerEintrag onHinzufuegen={gemeldet} />);
    await nutzer.click(screen.getByRole('button', { name: 'hinzufügen' }));
    expect(gemeldet).not.toHaveBeenCalled();
  });

  test('3.2 Liste zeigt, fügt hinzu und zählt offene', async () => {
    const nutzer = userEvent.setup();
    render(<Aufgabenliste anfang={[{ id: 1, text: 'Lernen', erledigt: false }]} />);

    expect(screen.getByTestId('offen')).toHaveTextContent('1 offen');

    await nutzer.type(screen.getByLabelText('Aufgabe'), 'Einkaufen');
    await nutzer.click(screen.getByRole('button', { name: 'hinzufügen' }));

    expect(screen.getAllByRole('listitem')).toHaveLength(2);
    expect(screen.getByTestId('offen')).toHaveTextContent('2 offen');
  });

  test('3.2 Checkbox schaltet erledigt um', async () => {
    const nutzer = userEvent.setup();
    render(<Aufgabenliste anfang={[{ id: 1, text: 'Lernen', erledigt: false }]} />);

    await nutzer.click(screen.getByLabelText('Lernen'));
    expect(screen.getByTestId('offen')).toHaveTextContent('0 offen');
    expect(screen.getByRole('listitem')).toHaveClass('erledigt');
  });

  test('3.2 löschen entfernt den richtigen Eintrag', async () => {
    const nutzer = userEvent.setup();
    render(
      <Aufgabenliste
        anfang={[
          { id: 1, text: 'Lernen', erledigt: false },
          { id: 2, text: 'Einkaufen', erledigt: false },
        ]}
      />,
    );
    const ersteZeile = screen.getAllByRole('listitem')[0];
    await nutzer.click(within(ersteZeile).getByRole('button', { name: 'löschen' }));

    const uebrig = screen.getAllByRole('listitem');
    expect(uebrig).toHaveLength(1);
    expect(uebrig[0]).toHaveTextContent('Einkaufen');
  });
});
