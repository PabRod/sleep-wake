%% Clean environment
close all;
clear;
clc;

%% PR model
% As described in in:
% Strogatz, S. H. (1987). 
% Human sleep and circadian rhythms: a simple model based on two coupled oscillators. 
% Journal of Mathematical Biology, 25(3), 327–347. http://doi.org/10.1007/BF00276440
pars = genPars('strogatz1987');
pars.w2 = 0.835 / 24; % Transition at 0.84 / 24 h^-1

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