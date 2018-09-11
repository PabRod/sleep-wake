function [ys, awake, bounds] = borbely(ts, y_init, awake_init, pars)
%BORBELY Simulates the two-process sleep-wake 
% As described in in Skeldon AC, Dijk D-J, Derks G. Mathematical Models for Sleep-Wake Dynamics: 
% Comparison of the Two-Process Model and a Mutual Inhibition Neuronal Model.
% Available from: http://dx.plos.org/10.1371/journal.pone.0103877
%
%   Outputs:
%
%   ys: the time series of the homeostatic pressure
%   awake: true if awake, false if sleeping
%   bounds: upper (1st row) and lower bound (2nd row)

%% Initialize
ys = NaN(1, numel((ts)));
ys(1) = y_init;

awake = false(1, numel(ts));
awake(1) = awake_init;

%% Create governing dynamics
% Homeostatic pressure
H_s = @(t, H_0) H_0*exp(-t./pars.xi_s);
H_w = @(t, H_0) pars.mu + (H_0 - pars.mu)*exp(-t/pars.xi_w);

% Circadian process
C = @(t) sin(pars.w.*t - pars.alpha);

% Upper and lower bounds
H_u = @(t) pars.H_u_0 + pars.a.*C(t);
H_l = @(t) pars.H_l_0 + pars.a.*C(t);

bounds(1, :) = H_u(ts); % Output them as vectors
bounds(2, :) = H_l(ts);

%% Simulate
for i = 2:numel(ts)
    % Awake/Sleep status-dependent calculation
    ys(i) = awake(i-1)*H_w(ts(i)-ts(i-1), ys(i-1)) + (~awake(i-1))*H_s(ts(i)-ts(i-1), ys(i-1));
    
    % Awake/Sleep trigger
    between_bounds = (ys(i) <= bounds(1,i)) && (ys(i) >= bounds(2,i));
    if (between_bounds)
        awake(i) = awake(i-1);
    else % If we go out of bounds..
        awake(i) = ~awake(i-1); % ... reverse awake/sleep status ...
        
        % And override state
        ys(i) = (~awake(i-1))*H_w(ts(i)-ts(i-1), ys(i-1)) + awake(i-1)*H_s(ts(i)-ts(i-1), ys(i-1));
        
        % If the rate is not fast enough to get away from the boundaries,
        % truncate to the boundary value
        if awake(i) && (ys(i) >= bounds(1, i)) % If awake, use upper bound
            ys(i) = bounds(1, i);
        elseif ~awake(i) && (ys(i) <= bounds(2, i)) % If sleeping, use lower bound
            ys(i) = bounds(2, i);
        end
    end
    
end

