%% Clean environment
close all;
clear;
clc;

%% PR model
% As described in in:
% Robinson PA, Phillips AJK et al. 
% Quantitative modelling of sleep dynamics. Trans R Soc A. 2011. 
% http://rsta.royalsocietypublishing.org/

pars.Qmax = 100;
pars.theta = 10;
pars.sigma = 3;

pars.tauv = 10;
pars.taum = 10;
pars.vvm = 2.1;
pars.vmv = 1.8;
pars.vvh = 1.0;
pars.vvc = 2.9;
pars.Av = 13.05;
pars.Am = 1.3;

pars.mu = 4.4;
pars.Xi = 45*3600;

T = 3600*24;
pars.w = 2*pi/T;
pars.c0 = 4.5;
pars.alpha = 0;

%% Generate time series
ts = [0, 3600*24*5];
y_init = [4, -20, 6];
[ts, ys] = philrob(ts, y_init, pars);

%% Plot results
plot(ts, ys);
legend('Vv', 'Vm', 'H');