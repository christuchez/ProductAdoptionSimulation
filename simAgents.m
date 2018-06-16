function Adoptions = simAgents (numAgents, Network, theta, d, ...
				initialAdoptionsProbability, numTimeSteps)
% simAgents  Simulate product adoptions over time using an agent-based model
%
%   numAgents
%     The number of agents to simulate.
%
%   Network(1:numAgents, 1:numAgents) or empty matrix ('[]')
%     Neighborhood connectivity matrix. Element (i, j) should be set
%     to 1 if agent 'i' is influenced by agent 'j', or 0 otherwise.
%
%     If Network == [] (empty array), then it is assumed that all
%     agents are influenced by all other agents.
%
%   theta, d
%     Parameters of the product value function.
%
%   initialAdoptionsProbability
%     The probability that an agent is an initial adopter.
%
%   numTimeSteps
%     Number of simulation time steps to take.
%

  isFullyConnected = (prod (size (Network)) == 0);

% Adoptions(t) = # of adoptions at time step t
  Adoptions = zeros (numTimeSteps, 1);

% Randomly make a fraction of these agents adopters
  Adopters = (rand (numAgents, 1) <= initialAdoptionsProbability);

% Determine the number of neighbors per agent
  if isFullyConnected,
    NumNeighbors = numAgents - 1;
  else
    NumNeighbors = sum (Network, 2);
  end

% Main simulation time loop
  for t=1:numTimeSteps,
  % Record the number of adopters at time t
    Adoptions(t) = sum (Adopters);
    
  % For each agent, measure the fraction of neighbors who are adopters
    if isFullyConnected,
    % The popularity is the same for all agents.
    % Popularity is a scalar value:
      Popularity = sum (Adopters) / numAgents;
    else
    % The popularity depends on the number of adopting neighbors.
    % Popularity(k) = fraction of k's neighbors who are adopters
      Popularity = (Network * Adopters) ./ NumNeighbors;
    end

  % Compute each agent's perceived value for the product
    PerceivedValue = getProductValue (Popularity, theta, d);

  % Simulate adoption spreading, in proportion to the perceived values
    New_adopters = (1 - Adopters) .* (rand (numAgents, 1) <= PerceivedValue);
    Adopters = Adopters + New_adopters;
  end

% eof
