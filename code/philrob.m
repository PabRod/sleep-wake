function [ts, ys] = philrob(ts, y_init, pars)
%PHILROB Summary of this function goes here
%   Detailed explanation goes here

dy = dphilrob(pars);

sol = ode45(dy, ts, y_init);

ts = sol.x;
ys = sol.y;

end

