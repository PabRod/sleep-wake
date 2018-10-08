%% Clean environment
close all;
clear;
clc;

%% Two cycles model
% Own toy model
pars = genPars('twocycles');
pars.p = 0.19;
pars.wp = 2*pi/5000;

%% Generate time series
nDays = 365; % d
ts_h = [0, nDays*24]; % Expected units are h
y_init = [0.1, 0];
[ts_h, ys, asleep] = twocycles(ts_h, y_init, pars);
ts_d = ts_h./24;


%% Plot results

% Time series
close all;
subplot(2, 2, 1);
plot(ts_d, ys);
title('Time series');
xlabel('Time');

% Aesthetics
% ax = gca();
% ax.XTick = 0:ts(end);
% ax.XGrid = 'on';
% ax.GridColor = 'k';
% ax.GridAlpha = 0.5;
% ax.GridLineStyle = '-';

%% Phase space
subplot(2, 2, 3);
plot(ys(1,:), ys(2,:));
title('Phase space');
axis equal;

%%
subplot(2, 2, [2, 4]);
rasterPlot(ts_d, asleep);