%% Clean environment
close all;
clear;
clc;

%% Load parameters
pars = genPars('philrob2007');

%% Create frames
% Choose sweeping parameter
name = 'vvc';

default_par = pars.vvc;
% sweeping_p = linspace(0.0*default_par, 0.1*default_par, 2);
sweeping_p = linspace(0.2, 4, 100);
nFrames = numel(sweeping_p);
for i = 1:nFrames
    %% Update parameters structure with new value
    pars = setfield(pars, name, sweeping_p(i));
    
    %% Generate time series
    % Stabilization run (don't use if sweeping parameter is w)
    nDays_stabil = 3; % d
    ts = [0, 3600*24*nDays_stabil]; % Expected units are s
    y_init = [-13, 1, 10];
    [~, ys] = philrob(ts, y_init, pars);
    
    % Run inside the attractor
    nDays = 3; % d
    ts = [0, 3600*24*nDays]; % Expected units are s
    y_init = ys(:, end);
    [ts, ys, asleep] = philrob(ts, y_init, pars);
    
    %% Auxiliary variables
    % For prettier plots
    forcing = 0.5*pars.vvc*(1 + cos(pars.w.*(ts - pars.alpha)));
    ts_days = ts./(3600*24); % Time in days improves plots' readability
    
    %% Plot results
    % Time series
    close all;
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2, 2, [1, 3]);
    plot(ts_days, ys);
    hold on;
    plot(ts_days, forcing, 'Color', 'k', 'LineStyle', '--');
    title(sprintf('Time series. %s = %0.7f', name, sweeping_p(i)));
    xlabel('Time (days)');
    legend('Vv (sleep)', 'Vm (wake)', 'H (somnogen)', 'Forcing', 'Location', 'SouthEast');
    
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
    
    % Raster plot
    subplot(2, 2, 4);
    rasterPlot(ts_days, asleep);
    filename = sprintf('../img/animations/%04d', i);
    saveas(gcf, filename, 'png');
end