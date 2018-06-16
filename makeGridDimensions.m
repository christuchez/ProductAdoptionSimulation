function Dims = makeGridDimensions (n, numDims)

  PrimeFactors = factor (n);
  Padding = ones (1, mod (length (PrimeFactors), numDims));
  FactorList = [PrimeFactors Padding];
  numFactorsPerDim = (length (PrimeFactors) + length (Padding)) / numDims;
  DimFactors = reshape (FactorList, numDims, numFactorsPerDim);
  Dims = prod (DimFactors, 2);
  
% eof
