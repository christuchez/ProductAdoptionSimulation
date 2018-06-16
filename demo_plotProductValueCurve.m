% ============================
% Demo: Plot the 'value' curve
% ============================

% Setup main model parameters
theta = 0.4;
d = 4;

figure (1);
clf;
fig1 = plotProductValueCurve ((1:100) / 100, theta, d);

% eof
