%% Input parser default
dy = dphilrob();

dy_example = dy(0, [1;2;3]);
d = size(dy_example);
assert(d(1) == 3);
assert(d(2) == 1);

%% Input parser non-default
dy = dphilrob('alpha', pi, 'Xi', 3);

dy_example = dy(0, [1;2;3]);
d = size(dy_example);
assert(d(1) == 3);
assert(d(2) == 1);

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

dy = dphilrob(pars);

dy_example = dy(0, [1;2;3]);
d = size(dy_example);
assert(d(1) == 3);
assert(d(2) == 1);