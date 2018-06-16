function figHandle = plotAdoptionsODEvsAgents (Time_ode, Adoptions_ode, ...
					       Time_agents, Adoptions_agents, ...
					       startTime, stopTime)

  if nargin < 6,
    stopTime = max ([max(Time_ode) max(Time_agents)]);
  end
  if nargin < 5,
    startTime = min ([min(Time_ode) min(Time_agents)]);
  end

  Median = median (Adoptions_agents, 2);
  Mean = mean (Adoptions_agents, 2);
  Std = std (Adoptions_agents, 0, 2);
  
  figHandle = plotAdoptionsOverTime (Time_ode, Adoptions_ode);
  hold on;
  plot (Time_agents, Median, '--' ...
	, Time_agents, Mean, '-' ...
	, Time_agents, Mean+Std, ':' ...
	, Time_agents, Mean-Std, ':' ...
       );
  legend('Theoretical', 'Median','Mean', 'Mean+Std', 'Mean-Std');
  hold off;
  
% eof
