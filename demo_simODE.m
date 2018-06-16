% ==========================
% Demo: ODE-based simulation
% ==========================

% Setup main model parameters
theta = 0.4;
d = 4;
initialAdoptionsProbability = 0.05;
startTime = 0;
stopTime = 150;

% Solve ODE to compute the fraction of adopters over time
[Time_ode, Adoptions_ode] = simODE (theta, d, ...
				    initialAdoptionsProbability, ...
				    startTime, stopTime);

% Plot the fraction of adopters over time
plotAdoptionsOverTime (Time_ode, Adoptions_ode, startTime, stopTime);

% eof
