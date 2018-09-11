function [ts, ys] = philrob(ts, y_init, pars)
%PHILROB Wrapper for the Phillips-Robinson sleep wake cycle model
%   Returns the integrated time series for the given conditions
%
%   Reference:
%   Robinson PA, Phillips AJK et al. 
%   Quantitative modelling of sleep dynamics. Trans R Soc A. 2011. 
%   http://rsta.royalsocietypublishing.org/

dy = dphilrob(pars);

sol = ode45(dy, ts, y_init);

ts = sol.x;
ys = sol.y;

end