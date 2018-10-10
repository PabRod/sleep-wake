%% Clean environment
close all;
clear;
clc;

%% Load parameters
pars = genPars('philrob2007');

%% Create frames
% Choose sweeping parameter
name = 'Qmax';

% default_par = pars.Qmax;
% sweeping_p = linspace(0.03*default_par, 0.07*default_par, 50);
sweeping_p = (150:50:800)*3600;
nFrames = numel(sweeping_p);
for i = 1:nFrames
    %% Update parameters structure with new value
    pars = setfield(pars, name, sweeping_p(i));
    
    %% Generate time series
    % Stabilization run (don't use if sweeping parameter is w)
    nDays_stabil = 2; % d
    ts = [0, 24*nDays_stabil]; % Expected units are h
    y_init = [-13, 1, 10];
    [~, ys] = philrob(ts, y_init, pars);
    
    % Run inside the attractor
    nDays = 10; % d
    ts = [0, 24*nDays]; % Expected units are h
    y_init = ys(:, end);
    [ts, ys, asleep] = philrob(ts, y_init, pars);
    
    %% Auxiliary variables
    % For prettier plots
    forcing = 0.5*pars.vvc*(1 + cos(pars.w.*(ts - pars.alpha)));
    ts_days = ts./24; % Time in days improves plots' readability
    
    %% Plot results
    rasterPlot(ts_days, asleep);
    title(sprintf('Raster plot. %s = %0.7f', name, sweeping_p(i)));
    
    filename = sprintf('../img/animations/%04d', i);
    saveas(gcf, filename, 'png');
end