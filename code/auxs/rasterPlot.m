function rasterPlot(ts, asleep)
%RASTERPLOT Generates a somnogram / raster plot

%% Reshape the asleep vector
% To turn it into a raster matrix
awake_fun = @(t) interp1(ts, 1.0.*(~asleep), t, 'nearest');

nDays = floor(ts(end));
nDailySamples = 1000;
raster = NaN(nDays-1, nDailySamples);
for i = 1:nDays-1
    ts_eval = linspace(i-1, i+1, nDailySamples); % Evaluate two days per row
    raster(i, :) = awake_fun(ts_eval);
end

%% Rescale the time vector with units
ts_hours = linspace(0, 48, nDailySamples); % Each row covers two days

%% Plot
imagesc(ts_hours, 0:nDays, raster);
title('Raster plot');
xlabel('h');
ylabel('Day');
xticks([0 6 12 18 24 30 36 42 48]);
xticklabels({'0','6','12','18','0','6','12','18','0'});

end
