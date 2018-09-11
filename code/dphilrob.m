function dy = dphilrob(pars)
%DPHILROB Summary of this function goes here
%   Detailed explanation goes here

% Auxiliary functions
C = @(t) pars.c0 + cos(pars.w.*(t - pars.alpha));
Q = @(V) pars.Qmax./(1 + exp((pars.theta-V)./pars.sigma));

% Differential equation
dy = @(t, y) [(-pars.vvm*Q(y(2)) + pars.Av - y(1) + pars.vvh*y(3) - pars.vvc*C(t))./pars.tauv; 
              (-pars.vmv*Q(y(1)) + pars.Am - y(2))./pars.taum;
              (pars.mu*Q(y(2)) - y(3))./pars.Xi];

end