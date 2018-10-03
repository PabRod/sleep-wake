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
default = genPars('philrob2007');

% Flexible parsing
p = inputParser;
p.addParameter('Qmax', default.Qmax);
p.addParameter('theta', default.theta);
p.addParameter('sigma', default.sigma);
p.addParameter('vmaSa', default.vmaSa);
p.addParameter('vvm', default.vvm);
p.addParameter('vmv', default.vmv);
p.addParameter('vvc', default.vvc);
p.addParameter('vvh', default.vvh);
p.addParameter('Xi', default.Xi);
p.addParameter('mu', default.mu);
p.addParameter('taum', default.taum);
p.addParameter('tauv', default.tauv);
p.addParameter('w', default.w);
p.addParameter('D', default.D);
p.addParameter('Da', default.Da);
p.addParameter('alpha', default.alpha);

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