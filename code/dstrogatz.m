function dy = dstrogatz(varargin)
%DSTROGATZ Strogatz sleep wake cycle model
%   Returns the function handle for the differential equation, ready to be 
%   integrated by ode45 or any other Matlab solver.
%
%   Output:
%
%   dy(1) = @(t,y) theta_1' (circadian cycle phase's derivative)
%   dy(2) = @(t,y) theta_2' (sleep wake cycle phase's derivative)
%
%   Examples:
%
%   Return the function handle with default parameters:
%   dy = dstrogatz();
%
%   Return the function handle with some parameters overriden:
%   dy = dstrogatz('w1', 0.9, 'C1', 0.1);
%
%   Return the function handle with custom parameters:
%   pars.w1 = 1;
%   pars.C1 = 0;
%   pars.w2 = 0.86;
%   ...
%   ... % All parameters should be defined inside the structure
%   ...
%   dy = dstrogatz(pars);
%
%   Reference:
%   Strogatz, S. H. (1987). 
%   Human sleep and circadian rhythms: a simple model based on two coupled oscillators. 
%   Journal of Mathematical Biology, 25(3), 327–347. http://doi.org/10.1007/BF00276440

%% Parse input
% Default values taken from the paper mentioned above
default = genPars('strogatz1987');

% Flexible parsing
p = inputParser;
p.addParameter('w1', default.w1);
p.addParameter('w2', default.w2);
p.addParameter('C1', default.C1);
p.addParameter('C2', default.C2);

p.parse(varargin{:});
pars = p.Results;

%% Build the differential equation
dy = @(t, y) [pars.w1; pars.w2] + [-pars.C1; pars.C2].*cos(2*pi*(y(1)-y(2)));

end