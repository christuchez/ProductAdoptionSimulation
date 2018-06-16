function plotAdoptionsAgainstAgents (networkTime, networkAdoptions, ...
					       agentTime, Adoptions_agents, numAgents, numTrials)

  networkMedian = median (networkAdoptions, 2);
  networkMean = mean (networkAdoptions, 2);
  networkStd = std (networkAdoptions, 0, 2);
  
  Median = median (Adoptions_agents, 2);
  Mean = mean (Adoptions_agents, 2);
  Std = std (Adoptions_agents, 0, 2);
  
  plot (agentTime, networkMedian, '--' ...
	, agentTime, networkMean, '-' ...
	, agentTime, networkMean+networkStd, ':' ...
	, agentTime, networkMean-networkStd, ':' ...
       );
  hold on;
  plot (agentTime, Median, '--' ...
	, agentTime, Mean, '-' ...
	, agentTime, Mean+Std, ':' ...
	, agentTime, Mean-Std, ':' ...
       );
  grid on;
  set (gca, 'FontSize', 18);
  ylabel ('Fraction of Adopters');
  xlabel ('Time (Days)');
  axis([0, 150, 0, 1]);
  hold off;
  
% eof
