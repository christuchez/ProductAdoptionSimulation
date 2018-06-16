% =====================================
% Demo: ODE- vs. Agent-based simulation
% =====================================

% Setup main model parameters
theta = 0.4;
d = 4;
initialAdoptionsProbability = 0.05;

% ODE-specific parameters
startTime = 0;
stopTime = 150;

% Agent-based model parameters
numAgents = 1000;
numTrials = 10; % for the agent-based model

% -------------------------------------------------------
% Solve ODE to compute the fraction of adopters over time
% -------------------------------------------------------
[Time_ode, Adoptions_ode] = simODE (theta, d, ...
				    initialAdoptionsProbability, ...
				    startTime, stopTime);

% -------------------------------------------------------
% Simulate an agent-based model
% -------------------------------------------------------
numSteps = stopTime - startTime + 1;

Network = []; % Assume fully connected
%Network = makeRandomNetwork (numAgents, 10); % random

tic; % start timer
Adoptions_total = zeros (numSteps, numTrials);
for trial=1:numTrials,
  Adoptions = simAgents (numAgents, Network, theta, d, ...
			 initialAdoptionsProbability, numSteps);
  Adoptions_total(:, trial) = Adoptions;
end
fprintf ('  (Done; elapsed time: %g seconds)\n', toc);

Time_agents = (1:numSteps)';
Adoptions = Adoptions_total / numAgents; % normalize

% -------------------
% Compare the results
% -------------------
plotAdoptionsODEvsAgents (Time_ode, Adoptions_ode, ...
			  Time_agents, Adoptions_total / numAgents);
title (sprintf ('Fraction of adopters: %d agents [%d trial(s)]', numAgents, numTrials));

% eof
