import React from 'react';
import { render } from '@testing-library/react';
import App from './App';

test('renders hello world paragraph element', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/Hello World, my name is Onyedikachi Okwa/i);
  expect(linkElement).toBeInTheDocument();
});
