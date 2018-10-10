% Parameters
nDays_short = 0.1; % d
ts_short = [0, 24*nDays_short]; % Expected units are h
nDays_long = 8; % d
ts_long = [0, 24*nDays_long]; % Expected units are h

y_init = [-13, 1, 10];

dyTol = 1e-3*3600; % mV h^-1

%% Input parser default
[ts_short, ys, asleep] = philrob(ts_short, y_init);

d = size(ys);
assert(d(1) == 3);
assert(islogical(asleep));

%% Input parser non-default
[ts_short, ys, asleep] = philrob(ts_short, y_init, 'alpha', pi, 'Xi', 3);

d = size(ys);
assert(d(1) == 3);
assert(islogical(asleep));

%% Input parser complete
pars.Qmax = 100*3600; % h^-1
pars.theta = 10; % mV
pars.sigma = 3; % mV

pars.vmaSa = 1; % mV
pars.vvm = 1.9/3600; % mV h (negative effect)
pars.vmv = 1.9/3600; % mV h (negative effect)
pars.vvc = 6.3; % mV (negative effect)
pars.vvh = 0.19; % mV nM^-1

pars.Xi = 10.8; % h
pars.mu = 1e-3; % nM h

pars.taum = 10/3600; % h
pars.tauv = 10/3600; % h

T = 24; % h
pars.w = 2*pi/T; % h^-1
pars.D = 0.77; % mV
pars.Da = 0.42; % mV
pars.alpha = 0.0; % rad

[ts_short, ys, asleep] = philrob(ts_short, y_init, pars);

d = size(ys);
assert(d(1) == 3);
assert(islogical(asleep));

%% Stable solution
% Kill all sources
[ts_long, ys, ~] = philrob(ts_long, y_init, 'vmaSa', 0.0, 'vvc', 0.0);

% Check an equilibrium is reached
dy = dphilrob('vmaSa', 0.0, 'vvc', 0.0);
dy_asymptote = dy(ts_long(end), ys(:,end));
assert(max(abs(dy_asymptote)) < dyTol);

%% Only V oscillates
% Kill mutual inhibition
[ts_long, ys, ~] = philrob(ts_long, y_init, 'vvm', 0.0, 'vmv', 0.0);

% Check V_m and H stay stable
dy = dphilrob('vvm', 0.0, 'vmv', 0.0);
dy_asymptote = dy(ts_long(end), ys(:,end));
assert(max(abs(dy_asymptote(2:3))) < dyTol);

%% Philrob 2007
% Simulate paper example (http://journals.sagepub.com/doi/10.1177/0748730406297512)
pars = genPars('philrob2007');
y_init_att = [-12.6404; 0.8997; 12.5731];
[ts_long, ys, asleep] = philrob(ts_long, y_init_att, pars);

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

assert(islogical(asleep));
assert(~asleep(1));
assert(sum(asleep)/numel(asleep) < 0.4);
assert(sum(asleep)/numel(asleep) > 0.2); 