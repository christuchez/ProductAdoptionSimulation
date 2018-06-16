function figHandle = plotProductValueCurve (X, theta, d)
  V = getProductValue (X, theta, d);
  figHandle = plot (X, V);
  title (sprintf('Value  [\\theta=%.2f, d=%d]', theta, d));
  xlabel ('Fraction of people who adopted the product');
  grid on;
  axis ([0 1 0 1]);
  axis square;
  set (gca, 'FontSize', 18);

% eof
