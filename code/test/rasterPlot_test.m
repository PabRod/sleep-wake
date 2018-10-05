%% Basic
% Generate time series
nDays = 3; % d
ts = [0, 3600*24*nDays]; % Expected units are s
y_init = [-10, 1, 10];
[ts, ys, asleep] = philrob(ts, y_init);
ts_days = ts./(3600*24);

% Just check it doesn't crash
close all;
rasterPlot(ts_days, asleep);
close all;