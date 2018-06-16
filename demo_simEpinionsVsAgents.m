% =====================================
% Demo: Epinions vs. Agent-based simulation
% =====================================

% Setup main model parameters
theta = 0.4;
d = 4;
initialAdoptionsProbability = 0.05;

% ODE-specific parameters
startTime = 0;
stopTime = 150;

% Agent-based model parameters
numTrials = 100; % for the agent-based model
TITLE = 'Epinions';
numSteps = stopTime - startTime + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   EPINIONS DATA                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Download
Epinions1Data = UFget('SNAP/soc-Epinions1');

% Extract the sparse matrix representing who-trusts-whom
Network = Epinions1Data.A; 

% Note the number of agents in this network
numAgents = min (size (Network));

% Optional: Visualize the sparse matrix (Network)
spy (Network)

tic; % start time
epinionsAdoptionsTotal = zeros (numSteps, numTrials);
for trial=1:numTrials,
  epinionsAdoptions = simAgents (numAgents, Network, theta, d, ...
			 initialAdoptionsProbability, numSteps);
  epinionsAdoptionsTotal(:, trial) = epinionsAdoptions;
end
fprintf ('  (Done; elapsed time: %g seconds)\n', toc);

degreeOfEpinions = nnz(Network)/max(size(Network));
epinionsTime = (1:numSteps)';
epinionsAdoptions = epinionsAdoptionsTotal / numAgents; % normalize

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     AGENT DATA                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
agentsNetwork = makeRandomNetwork (numAgents, degreeOfEpinions); % random

tic; % start timer
agentAdoptionsTotal = zeros (numSteps, numTrials);
for trial=1:numTrials,
  agentAdoptions = simAgents (numAgents, agentsNetwork, theta, d, ...
			 initialAdoptionsProbability, numSteps);
  agentAdoptionsTotal(:, trial) = agentAdoptions;
end
fprintf ('  (Done; elapsed time: %g seconds)\n', toc);
agentTime = (1:numSteps)';
agentAdoptions = agentAdoptionsTotal / numAgents; % normalize

display( sprintf('Num Agents: %d', numAgents));
display( sprintf('Degree of Epinions: %d', degreeOfEpinions));

% ------------------------------------------
% Plotting Epinions vs Uniform Random Agents
% ------------------------------------------
plotAdoptionsAgainstAgents (epinionsTime, epinionsAdoptions, ...
			  agentTime, agentAdoptions, numAgents, numTrials);  
title (sprintf ('%s vs Agents: [%d Agents, %d Trials]', TITLE, numAgents, numTrials));
% eof
