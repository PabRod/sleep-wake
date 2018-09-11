%% Boundaries
% Parameters
pars.xi_s = 4.2/24;
pars.mu = 1;
pars.xi_w = 18.2/24;

T = 1;
pars.a = 0.1;
pars.w = 2*pi/T;
pars.alpha = 0;
pars.H_u_0 = 0.85;
pars.H_l_0 = 0.1;

% Generate time series
step = 1e-2;
ts = 0:step:30;
y_0 = mean([pars.H_u_0, pars.H_l_0]);

[y, awake, bounds] = borbely(ts, y_0, true, pars);

% Check that the time series is always between the boundaries
below_upper_bound = (y <= bounds(1,:));
above_lower_bound = (y >= bounds(2,:));

assert(all(below_upper_bound & above_lower_bound));

%% Fast circadian
% Parameters
pars.xi_s = 4.2/24;
pars.mu = 1;
pars.xi_w = 18.2/24;

T = 1;
pars.a = 0.3;
pars.w = 2*pi/T;
pars.alpha = 0;
pars.H_u_0 = 0.85;
pars.H_l_0 = 0.1;

% Generate time series
step = 1e-2;
ts = 0:step:30;
y_0 = mean([pars.H_u_0, pars.H_l_0]);

[y, awake, bounds] = borbely(ts, y_0, true, pars);

% Check that the time series is always between the boundaries
below_upper_bound = (y <= bounds(1,:));
above_lower_bound = (y >= bounds(2,:));

assert(all(below_upper_bound & above_lower_bound));