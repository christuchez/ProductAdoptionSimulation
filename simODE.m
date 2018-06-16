function [Time, Adoptions] = simODE (theta, d, initialAdoptions, startTime, stopTime)
% simODE  Simulate product adoptions over time using the ODE model
% 
%   theta, d
%     Parameters of the product value function.
%
%   initialAdoptionsProbability
%     The probability that an agent is an initial adopter.
%
%   startTime, stopTime
%     Time period to simulate.
%  

  fprintf ('=== ODE-based simulation ===\n'); tic;

% 'densityChange()' is the right-hand side of the ODE.
  function dRho = densityChange (T, Rho)
    % Computes the change in fraction of adoptions (Rho) per unit time.
    Value = getProductValue (Rho, theta, d);
    dRho = Value .* (1 - Rho);
  end

  [Time, Adoptions] = ode45 (@densityChange, [startTime stopTime], initialAdoptions);

  fprintf ('  (Done; elapsed time: %g seconds)\n', toc);
end

% eof
