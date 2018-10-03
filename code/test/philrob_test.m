% Parameters
nDays_short = 0.1; % d
ts_short = [0, 3600*24*nDays_short]; % Expected units are s
nDays_long = 6; % d
ts_long = [0, 3600*24*nDays_long]; % Expected units are s

y_init = [-13, 1, 10];

absTol = 1e-3;

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

%% Stable solution
% Kill all sources
[ts_long, ys] = philrob(ts_long, y_init, 'vmaSa', 0.0, 'vvc', 0.0);

% Check an equilibrium is reached
dy = dphilrob('vmaSa', 0.0, 'vvc', 0.0);
dy_asymptote = dy(ts_long(end), ys(:,end));
assert(max(abs(dy_asymptote)) < absTol);

%% Only V oscillates
% Kill mutual inhibition
[ts_long, ys] = philrob(ts_long, y_init, 'vvm', 0.0, 'vmv', 0.0);

% Check V_m and H stay stable
dy = dphilrob('vvm', 0.0, 'vmv', 0.0);
dy_asymptote = dy(ts_long(end), ys(:,end));
assert(max(abs(dy_asymptote(2:3))) < absTol);

%% Philrob 2007
% Simulate paper example (http://journals.sagepub.com/doi/10.1177/0748730406297512)
pars = importPars('philrob.csv', 'philrob2007');
y_init_att = [-12.6404; 0.8997; 12.5731];
[ts_long, ys] = philrob(ts_long, y_init_att, pars);

Vvs = ys(1,:);
Vms = ys(2,:);
Hs = ys(3,:);

% Approximate limits taken from Figure 5
assert(min(Vvs) > -13 && min(Vvs) < -10);
assert(max(Vvs) > 1 && max(Vvs) < 2);
assert(min(Vms) > -11 && min(Vms) < -10);
assert(max(Vms) > 0 && max(Vms) < 3);
assert(min(Hs) > 7 && min(Hs) < 9);
assert(max(Hs) > 14 && max(Hs) < 15);