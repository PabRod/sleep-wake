function dy = dphilrob(pars)
%DPHILROB Phillips-Robinson sleep wake cycle model
%   Returns the function handle for the differential equation, ready to be 
%   integrated by ode45 or any other Matlab integrating function
%
%   Reference:
%   Robinson PA, Phillips AJK et al. 
%   Quantitative modelling of sleep dynamics. Trans R Soc A. 2011. 
%   http://rsta.royalsocietypublishing.org/

% Auxiliary functions
C = @(t) pars.c0 + cos(pars.w.*(t - pars.alpha));
Q = @(V) pars.Qmax./(1 + exp((pars.theta-V)./pars.sigma));

% Differential equation
dy = @(t, y) [(-pars.vvm*Q(y(2)) + pars.Av - y(1) + pars.vvh*y(3) - pars.vvc*C(t))./pars.tauv; %Vv
              (-pars.vmv*Q(y(1)) + pars.Am - y(2))./pars.taum; % Vm
              (pars.mu*Q(y(2)) - y(3))./pars.Xi]; % H

end