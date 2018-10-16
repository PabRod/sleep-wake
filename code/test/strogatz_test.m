% Parameters
nDays_short = 0.1; % d
ts_short = linspace(0, 24*nDays_short, 24*nDays_short*10); % Expected units are h
nDays_long = 60; % d
ts_long = linspace(0, 24*nDays_long, 24*nDays_long*10); % Expected units are h

y_init = [0.0; 0.1];

absTol = 1e-5;

%% Input parser default
[ts_short, ys, asleep] = strogatz(ts_short, y_init);

d = size(ys);
assert(d(1) == 2);
assert(islogical(asleep));

%% Input parser non-default
[ts_short, ys, asleep] = strogatz(ts_short, y_init, 'w2', 0.9/24);

d = size(ys);
assert(d(1) == 2);
assert(islogical(asleep));

%% Input parser complete
% Frequencies
pars.w1 = 1/24; % h^-1
pars.w2 = 0.84/24; % h^-1

% Coupling
pars.C1 = 0/24; % h^-1
pars.C2 = 0.16/24; % h^-1

[ts_short, ys, asleep] = strogatz(ts_short, y_init, pars);

d = size(ys);
assert(d(1) == 2);
assert(islogical(asleep));

%% Stable solution
pars = genPars('strogatz1987');
pars.w2 = 0.9 / 24; % Override with an easy to entrain frequency

% Solve
[ts_long, ys, ~] = strogatz(ts_long, y_init, pars);

% Check an equilibrium is reached
omega = pars.w1 - pars.w2;
C = pars.C1 + pars.C2;
psi_eq_expected = -1/(2*pi)*acos(omega/C);

psi_eq = ys(1, end) - ys(2, end);

assert(abs(psi_eq - psi_eq_expected) < absTol);