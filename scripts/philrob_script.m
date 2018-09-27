%% Clean environment
close all;
clear;
clc;

%% PR model
% As described in in:
% Robinson PA, Phillips AJK et al. 
% Quantitative modelling of sleep dynamics. Trans R Soc A. 2011. 
% http://rsta.royalsocietypublishing.org/

pars.Qmax = 100; % s^-1
pars.theta = 10; % mV
pars.sigma = 3; % mV

pars.tauv = 10; % s
pars.taum = 10; % s
pars.vvm = 1.9; % mV s
pars.vmv = 1.9; % mV s
pars.vvh = 0.19; % mV nM^-1
pars.vvc = 6.3; % mV
pars.vmaSa = 1; % mV

pars.mu = 1e-3 * 3600; % nM s
pars.Xi = 10.8 * 3600; % s

T = 3600*24;
pars.w = 2*pi/T;
pars.c0 = 4.5;
pars.alpha = 0;

%% Generate time series
ts = [0, 3600*24*5];
y_init = [4, -20, 6];
[ts, ys] = philrob(ts, y_init, pars);

%% Plot results
close all;
subplot(1, 2, 1);
plot(ts, ys);
legend('Vv', 'Vm', 'H');

subplot(1, 2, 2);
plot3(ys(1,:), ys(2,:), ys(3,:));
axis equal;
xlabel('V_v');
ylabel('V_m');
zlabel('H');