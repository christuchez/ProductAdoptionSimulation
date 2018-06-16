function V = getProductValue (Rho, theta, d)
  V = (1 + theta.^d) ./ (1 + (theta./Rho).^d);

% eof
