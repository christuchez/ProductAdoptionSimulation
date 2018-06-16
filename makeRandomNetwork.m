function Network = makeRandomNetwork (n, averageDegree)

  Network = 1.0 * (sprand (n, n, averageDegree/n/2) ~= 0);
  Network = Network + Network';

% eof
