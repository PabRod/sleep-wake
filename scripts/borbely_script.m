%% Clean environment
close all;
clear;
clc;

%% Two-process/Borbely model
% As described in in Skeldon AC, Dijk D-J, Derks G. Mathematical Models for Sleep-Wake Dynamics: 
% Comparison of the Two-Process Model and a Mutual Inhibition Neuronal Model. 
% Available from: http://dx.plos.org/10.1371/journal.pone.0103877

% Homeostatic pressure
pars.xi_s = 4.2/24;
pars.mu = 1;
pars.xi_w = 18.2/24;

% Circadian process
T = 1;
pars.a = 0.17;
pars.w = 2*pi/T;
pars.alpha = 0;

% Upper and lower bounds
pars.H_u_0 = 0.85;
pars.H_l_0 = 0.1;

%% Generate time series
step = 1e-3;
ts = 0:1e-3:30;
y_0 = mean([pars.H_u_0, pars.H_l_0]);

[y, awake, bounds] = borbely(ts, y_0, true, pars);

%% Plot results
plot(ts, bounds, '--', 'Color', 'k');
hold on;
plot(ts, y, 'Color', 'r', 'LineWidth', 2);

% Some aesthetics
title('Homeostatic pressure');
xlabel('t');
ylabel('H(t)');

ax = gca();
ax.XTick = 0:ts(end);
ax.XGrid = 'on';
ax.GridColor = 'k';
ax.GridAlpha = 0.5;
ax.GridLineStyle = '-';