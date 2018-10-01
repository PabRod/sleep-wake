function dy = dphilrob(varargin)
%DPHILROB Phillips-Robinson sleep wake cycle model
%   Returns the function handle for the differential equation, ready to be 
%   integrated by ode45 or any other Matlab solver.
%
%   Output:
%
%   dy(1) = @(t,y) V_v';
%   dy(2) = @(t,y) V_m';
%   dy(3) = @(t,y) H';
%
%   Examples:
%
%   Return the function handle with default parameters:
%   dy = dphilrob();
%
%   Return the function handle with some parameters overriden:
%   dy = dphilrob('Qmax', 150, 'Theta', 9);
%
%   Return the function handle with custom parameters:
%   pars.Qmax = 150;
%   pars.Theta = 9;
%   pars.Sigma = 4;
%   ...
%   ... % All parameters should be defined inside the structure
%   ...
%   dy = dphilrob(pars);
%
%   Reference:
%   Phillips AJK, Robinson PA, Phillips A. 
%   A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of 
%   the Brainstem Ascending Arousal System. 
%   J Biol Rhythms. 2007 ;22(2):167–79. 
%   Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512

%% Parse input
% Default values taken from the paper mentioned above
defaultQmax = 100; % s^-1
defaultTheta = 10; % mV
defaultSigma = 3; % mV

defaultVmaSa = 1; % mV
defaultVvm = 1.9; % mV s (negative effect)
defaultVmv = 1.9; % mV s (negative effect)
defaultVvc = 6.3; % mV (negative effect)
defaultVvh = 0.19; % mV nM^-1

defaultXi = 10.8 * 3600; % s
defaultMu = 1e-3 * 3600; % nM s

defaultTaum = 10; % s
defaultTauv = 10; % s

T = 3600*24; % s
defaultW = 2*pi/T; % s^-1
defaultD = 0.77; % mV
defaultDa = 0.42; % mV
defaultAlpha = 0.0; % rad

% Flexible parsing
p = inputParser;
p.addParameter('Qmax', defaultQmax);
p.addParameter('theta', defaultTheta);
p.addParameter('sigma', defaultSigma);
p.addParameter('vmaSa', defaultVmaSa);
p.addParameter('vvm', defaultVvm);
p.addParameter('vmv', defaultVmv);
p.addParameter('vvc', defaultVvc);
p.addParameter('vvh', defaultVvh);
p.addParameter('Xi', defaultXi);
p.addParameter('mu', defaultMu);
p.addParameter('taum', defaultTaum);
p.addParameter('tauv', defaultTauv);
p.addParameter('w', defaultW);
p.addParameter('D', defaultD);
p.addParameter('Da', defaultDa);
p.addParameter('alpha', defaultAlpha);

p.parse(varargin{:});
pars = p.Results;

%% Build the differential equation
% Auxiliary functions
S = @(V) pars.Qmax./(1 + exp((pars.theta-V)./pars.sigma)); % Sigmoid growth
C = @(t) 0.5*(1 + cos(pars.w.*(t - pars.alpha))); % TODO: This is an approximation

% Coupling matrix
coupling = [0,          -pars.vvm,      pars.vvh;
            -pars.vmv,      0,          0;
            0,          pars.mu,        0];

% Saturated vector
satvec = @(y) [S(y(1));
               S(y(2));
               y(3)];

% Decay term
sink = @(y) y;

% Source term          
source = @(t,y) [-pars.vvc.*C(t); % Light/darkness coupling
                 pars.vmaSa; % Constant source from Acetylcholine group
                 0];
          
% Build the differential equation
dy = @(t, y) (coupling*satvec(y) + source(t,y) - sink(y))./[pars.tauv; pars.taum; pars.Xi];

end