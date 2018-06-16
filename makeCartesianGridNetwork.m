function Network = makeCartesianGridNetwork (n, numDims)
  if numDims ~= 2,
    error ('*** Only 2-D grids supported at present. ***');
  end
  
  Dims = makeGridDimensions (n, 2);
  x = Dims(1); y = Dims(2);
  I_x = speye (x);
  e_x = ones (x, 1);
  T_x = spdiags ([e_x e_x e_x], -1:1, x, x);
  I_y = speye (y);
  e_y = ones (y, 1);
  T_y = spdiags ([e_y e_y e_y], -1:1, y, y);
  Network = kron (I_x, T_y) + kron (T_x, I_y);

% eof
