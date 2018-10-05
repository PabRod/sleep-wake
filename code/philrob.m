function [ts, ys, asleep] = philrob(ts, y_init, varargin)
%PHILROB Wrapper for the Phillips-Robinson sleep wake cycle model
%   Returns the integrated time series for the given conditions
%
%   Output:
%
%   y(1,:) = V_v(t);
%   y(2,:) = V_m(t);
%   y(3,:) = H(t);
%
%   Reference:
%   Phillips AJK, Robinson PA, Phillips A. 
%   A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of 
%   the Brainstem Ascending Arousal System. 
%   J Biol Rhythms. 2007 ;22(2):167–79. 
%   Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512

%% Solve the differential equation
dy = dphilrob(varargin{:});

sol = ode45(dy, ts, y_init);

ts = sol.x;
ys = sol.y;

%% Build the asleep vector
Hs = ys(3, :); % Extract the homeostatic pressure.
dHs = gradient(Hs); % If it drops...
asleep = (dHs < 0); % ... that means the subject is asleep

end