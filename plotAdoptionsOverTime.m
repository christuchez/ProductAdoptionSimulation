function figHandle = plotAdoptionsOverTime (Time, Adoptions, t_start, t_stop)
  if nargin < 4,
    t_stop = max (Time);
  end
  if nargin < 3,
    t_start = min (Time);
  end
  
  figHandle = plot (Time, Adoptions);
  title ('Fraction of people who adopted the product');
  xlabel ('Time (days)');
  axis ([t_start t_stop 0 1]);
  grid on;
  set (gca, 'FontSize', 18);
  
% eof
  
