%% Clean environment
close all;
clear;
clc;

%% PR model
% As described in in:
% Phillips AJK, Robinson PA, Phillips A. 
% A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of 
% the Brainstem Ascending Arousal System. 
% J Biol Rhythms. 2007 ;22(2):167–79. 
% Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512
pars = genPars('philrob2007');

%% Generate time series
nDays = 15; % d
ts = [0, 3600*24*nDays]; % Expected units are s
y_init = [-10, 1, 10];
[ts, ys, asleep] = philrob(ts, y_init, pars);

%% Auxiliary variables
% For prettier plots
forcing = pars.D + pars.Da.*cos(pars.w.*(ts - pars.alpha));
ts_days = ts./(3600*24); % Time in days improves plots' readability

%% Plot results

% Time series
close all;
subplot(2, 2, [1, 3]);
plot(ts_days, ys);
hold on;
plot(ts_days, forcing, 'Color', 'k', 'LineStyle', '--');
title('Time series');
xlabel('Time (days)');
legend('Vv (sleep)', 'Vm (wake)', 'H (somnogen)', 'Forcing');

% Aesthetics
ax = gca();
ax.XTick = 0:ts_days(end);
ax.XGrid = 'on';
ax.GridColor = 'k';
ax.GridAlpha = 0.5;
ax.GridLineStyle = '-';

% Phase space
subplot(2, 2, 2);
plot3(ys(1,:), ys(2,:), ys(3,:));
title('Phase space');
axis equal;
xlabel('V_v (sleep)');
ylabel('V_m (wake)');
zlabel('H (somnogen)');

subplot(2, 2, 4);
rasterPlot(ts_days, asleep);