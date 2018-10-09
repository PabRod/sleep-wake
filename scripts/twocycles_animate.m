%% Clean environment
close all;
clear;
clc;

%% Load parameters
pars = genPars('twocycles');

%% Create frames
% Choose sweeping parameter
name = 'p';
sweeping_p = 0.375:0.005:0.475;
nFrames = numel(sweeping_p);
for i = 1:nFrames
    %% Update parameters structure with new value
    pars = setfield(pars, name, sweeping_p(i));
    
    %% Generate time series
    nDays = 150; % d
    ts_h = [0, nDays*24]; % Expected units are h
    y_init = [0.5, 0];
    [ts_h, ys, asleep] = twocycles(ts_h, y_init, pars);
    ts_d = ts_h./24;
    
    
    %% Plot results
    % Time series
    close all;
    figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(2, 2, 1);
    plot(ts_d, ys);
    title(sprintf('Time series. %s = %0.7f', name, sweeping_p(i)));
    xlabel('Time');
    ylim([-4 4]);
    
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
    xlim([-4 4]);
    ylim([-4 4]);
    axis equal;
    
    %%
    subplot(2, 2, [2, 4]);
    rasterPlot(ts_d, asleep);
    
    filename = sprintf('../img/animations/%04d', i);
    saveas(gcf, filename, 'png');
end