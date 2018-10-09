%% Basic test
% Create a polar flow
dr = @(t, r) -r(1);
dtheta = @(t, r) 3;
dy_pol = @(t, r) [dr(t, r); dtheta(t, r)];

% Translate to cartesian
dy_calc = polToCartFlow(dy_pol);

% Check results
dy_exact = @(t, y) [-y(1)-3*y(2); -y(2)+3*y(1)];

y_eval = [1; 2];
calculated = dy_calc(0, y_eval);
expected = dy_exact(0, y_eval);
assert(all(calculated == expected));

%% Parameters test
% Create a polar flow
pars.omega = 4;
dr = @(t, r, pars) -r(1);
dtheta = @(t, r, pars) pars.omega;
dy_pol = @(t, r, pars) [dr(t, r, pars); dtheta(t, r, pars)];

% Translate to cartesian
dy_calc = polToCartFlow(dy_pol, pars);

% Check results
dy_exact = @(t, y, pars) [-y(1)-pars.omega*y(2); -y(2)+pars.omega*y(1)];

y_eval = [1; 2];
calculated = dy_calc(0, y_eval);
expected = dy_exact(0, y_eval, pars);
assert(all(calculated == expected));