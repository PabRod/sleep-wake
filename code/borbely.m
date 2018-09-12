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
H_a = @(t, H_0) H_0*exp(-t./pars.xi_w); % Awake
H_s = @(t, H_0) pars.mu + (H_0 - pars.mu)*exp(-t/pars.xi_s); % Sleeping
H = @(t, H_0, awake) awake.*H_a(t, H_0) + (~awake).*H_s(t, H_0); % Combined

% Homeostatic pressure's derivatives
dH_a = @(H) -H./pars.xi_w; % Awake
dH_s = @(H) (pars.mu - H)./pars.xi_s; % Sleeping
dH = @(H, awake) awake.*dH_a(H) + (~awake).*dH_s(H); % Combined

% Circadian process
C = @(t) sin(pars.w.*t - pars.alpha);

% Upper and lower bounds
H_u = @(t) pars.H_u_0 + pars.a.*C(t);
H_l = @(t) pars.H_l_0 + pars.a.*C(t);

bounds(1, :) = H_u(ts); % Output them as vectors
bounds(2, :) = H_l(ts);

%% Simulate
for i = 2:numel(ts)
    % Update state
    ys(i) = H(ts(i)-ts(i-1), ys(i-1), awake(i-1));
    
    % Update awake/sleeping status
    wake_trigger = ~awake(i-1) && ys(i) >= bounds(1, i); % Sleeping and recovered
    sleep_trigger = awake(i-1) && ys(i) <= bounds(2, i); % Awake and tired
    if wake_trigger
        awake(i) = true; % Good morning!
        ys(i) = H(ts(i)-ts(i-1), ys(i-1), ~awake(i-1)); % TODO: decide if keep or remove this recalculation
    elseif sleep_trigger
        awake(i) = false; % Go to sleep
        ys(i) = H(ts(i)-ts(i-1), ys(i-1), ~awake(i-1)); % TODO: decide if keep or remove this recalculation
    else
        awake(i) = awake(i-1); % Keep status
    end

end
