function [ts, ys, asleep] = twocycles(ts, y_init, varargin)
%TWOCYCLES Wrapper my toy model
%
%   Output:
%
%   y(1,:) = x(t);
%   y(2,:) = y(t);

%% Solve the differential equation
dy = dtwocycles(varargin{:});

opts = odeset('RelTol', 1e-6,'AbsTol', 1e-9);
sol = ode45(dy, ts, y_init, opts);

ts = sol.x;
ys = sol.y;

%% Build the asleep vector
asleep = (ys(1,:) >= 0.0) & (ys(2,:) >= 0.0);

end