%% Clean environment
close all;
clear;
clc;

%% Model
% As described in in:
% Strogatz, S. H. (1987). 
% Human sleep and circadian rhythms: a simple model based on two coupled oscillators. 
% Journal of Mathematical Biology, 25(3), 327–347. http://doi.org/10.1007/BF00276440
pars = genPars('strogatz1987');
pars.w2 = 0.835 / 24; % Transition at 0.84 / 24 h^-1

%% Auxiliary variables
omega = pars.w1 - pars.w2;
C = pars.C1 + pars.C2;

isSync = abs(omega/C) <= 1;
if isSync
    T_beat = NaN;
else
    T_beat = 1/sqrt(omega^2 - C^2) / 24; % Beat period in days
    assert(isreal(T_beat));
end

%% Generate time series
nDays = 60; % d
ts = linspace(0, 24*nDays, 24*nDays*10); % Expected units are h
y_init = [0.0; 0.0];
[ts, ys, asleep] = strogatz(ts, y_init, pars);

ts_days = ts./24; % Time in days improves plots' readability

%% Plot results

% Time series
close all;
subplot(1, 2, 1);
plot(ts_days, rem(ys(1,:) - ys(2,:), 1));
title('Time series');
xlabel('Time (days)');
legend('\theta_1 - \theta_2');

% Aesthetics
ax = gca();
ax.XTick = 0:ts_days(end);
ax.XGrid = 'on';
ax.GridColor = 'k';
ax.GridAlpha = 0.5;
ax.GridLineStyle = '-';

subplot(1, 2, 2);
rasterPlot(ts_days, asleep);

if ~isSync
    title(sprintf('Raster plot \n Beat period: %0.2f days', T_beat));
end