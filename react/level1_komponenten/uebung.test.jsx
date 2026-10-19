import { render, screen } from '@testing-library/react';
import { describe, expect, test } from 'vitest';

import { Gruss, Kasten, Liste, Preis, Zustand } from './uebung.jsx';

describe('Level 1', () => {
  test('1.1 Gruss zeigt den Namen', () => {
    render(<Gruss name="Anna" />);
    expect(screen.getByText('Hallo, Anna!')).toBeInTheDocument();
  });

  test('1.2 Preis mit zwei Nachkommastellen', () => {
    render(<Preis betrag={19.9} />);
    expect(screen.getByText('19.90 €')).toBeInTheDocument();
  });

  test('1.3 Kasten zeigt Titel und Inhalt', () => {
    render(
      <Kasten titel="Hinweis">
        <p>Der Inhalt</p>
      </Kasten>,
    );
    expect(screen.getByRole('heading', { name: 'Hinweis' })).toBeInTheDocument();
    expect(screen.getByText('Der Inhalt')).toBeInTheDocument();
  });

  test('1.4 Zustand zeigt online und offline', () => {
    const { rerender } = render(<Zustand aktiv />);
    const an = screen.getByText('online');
    expect(an).toHaveClass('an');

    rerender(<Zustand aktiv={false} />);
    const aus = screen.getByText('offline');
    expect(aus).toHaveClass('aus');
  });

  test('1.5 Liste zeigt jeden Eintrag', () => {
    render(
      <Liste
        eintraege={[
          { id: 'a', name: 'Apfel' },
          { id: 'b', name: 'Birne' },
        ]}
      />,
    );
    const eintraege = screen.getAllByRole('listitem');
    expect(eintraege).toHaveLength(2);
    expect(eintraege[0]).toHaveTextContent('Apfel');
    expect(eintraege[1]).toHaveTextContent('Birne');
  });
});
