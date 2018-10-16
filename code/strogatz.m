function [ts, ys, asleep] = strogatz(ts, y_init, varargin)
%STROGATZ Wrapper for the Strogatz sleep wake cycle model
%   Returns the integrated time series for the given conditions
%
%   Output:
%
%   y(1,:) = theta_1(t); (circadian cycle phase)
%   y(2,:) = theta_2(t); (sleep wake cycle phase)
%
%   Reference:
%   Strogatz, S. H. (1987). 
%   Human sleep and circadian rhythms: a simple model based on two coupled oscillators. 
%   Journal of Mathematical Biology, 25(3), 327–347. http://doi.org/10.1007/BF00276440

%% Solve the differential equation
dy = dstrogatz(varargin{:});

opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-9);
sol = ode45(@(t,y) dy(t,y), ts, y_init, opts);

ts_sol = sol.x;
ys_sol = sol.y;

%% Interpolate for the desired times
ys(1,:) = interp1(ts_sol, ys_sol(1,:), ts);
ys(2,:) = interp1(ts_sol, ys_sol(2,:), ts);

%% Build the asleep vector
asleep = (rem(ys(2,:),1) >= 0) & (rem(ys(2,:), 1) <= 1/3);

end