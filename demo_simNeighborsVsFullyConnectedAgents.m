% ==========================================
% Demo: Neighbors vs. Agent-based simulation
% ==========================================

% Setup main model parameters
theta = 0.4;
d = 4;
initialAdoptionsProbability = 0.05;

% ODE-specific parameters
startTime = 0;
stopTime = 150;

% Agent-based model parameters
numAgents = 1000;
numTrials = 100; % for the agent-based model
NEIGHBORS = 100;
TITLE = 'Neighbors';
% -------------------------------------------------------
% Simulate an agent-based model
% -------------------------------------------------------
numSteps = stopTime - startTime + 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     AGENT DATA                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Network = []; % Assume fully connected

tic; % start timer
totalConnectedAdoptions = zeros (numSteps, numTrials);
for trial=1:numTrials,
  connectedAdoptions = simAgents (numAgents, Network, theta, d, ...
			 initialAdoptionsProbability, numSteps);
  totalConnectedAdoptions(:, trial) = connectedAdoptions;
end
fprintf ('  (Done; elapsed time: %g seconds)\n', toc);

connectedTime = (1:numSteps)';
connectedAdoptions = totalConnectedAdoptions / numAgents; % normalize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   RANDOM NETWORK                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

neighborNetwork = makeRandomNetwork (numAgents, NEIGHBORS); % random

tic; % start timer
neighborAdoptionsTotal = zeros (numSteps, numTrials);
for trial=1:numTrials,
  neighborAdoptions = simAgents (numAgents, neighborNetwork, theta, d, ...
			 initialAdoptionsProbability, numSteps);
  neighborAdoptionsTotal(:, trial) = neighborAdoptions;
end
fprintf ('  (Done; elapsed time: %g seconds)\n', toc);
neighborTime = (1:numSteps)';
neighborAdoptions = neighborAdoptionsTotal / numAgents; % normalize

display( sprintf('Num Agents: %d', numAgents));
% ------------------------------------------------
% Plotting Random Agents vs Fully Connected Agents
% ------------------------------------------------
plotAdoptionsAgainstAgents (neighborTime, neighborAdoptions, ...
			  connectedTime, connectedAdoptions, numAgents, numTrials); 
title (sprintf ('%s vs Agents: [%d Agents, %d Trials, %d = k]', TITLE, numAgents, numTrials, NEIGHBORS));
% eof
