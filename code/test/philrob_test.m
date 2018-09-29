% Parameters
nDays_short = 0.1; % d
ts_short = [0, 3600*24*nDays_short]; % Expected units are s
nDays_long = 4; % d
ts_long = [0, 3600*24*nDays_long]; % Expected units are s
y_init = [-13, 1, 10];

%% Input parser default
[ts_short, ys] = philrob(ts_short, y_init);

d = size(ys);
assert(d(1) == 3);

%% Input parser non-default
[ts_short, ys] = philrob(ts_short, y_init, 'alpha', pi, 'Xi', 3);

d = size(ys);
assert(d(1) == 3);

%% Input parser complete
pars.Qmax = 120; % s^-1
pars.theta = 9; % mV
pars.sigma = 2.5; % mV

pars.vmaSa = 1; % mV
pars.vvm = 1.9; % mV s (negative effect)
pars.vmv = 1.9; % mV s (negative effect)
pars.vvc = 6.3; % mV (negative effect)
pars.vvh = 0.19; % mV nM^-1

pars.Xi = 10.8 * 3600; % s
pars.mu = 1e-3 * 3600; % nM s

pars.taum = 10; % s
pars.tauv = 10; % s

T = 3600*24; % s
pars.w = 2*pi/T; % s^-1
pars.D = 0.77; % mV
pars.Da = 0.42; % mV
pars.alpha = 0; % rad

[ts_short, ys] = philrob(ts_short, y_init, pars);

d = size(ys);
assert(d(1) == 3);