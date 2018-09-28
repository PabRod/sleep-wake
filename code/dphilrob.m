function dy = dphilrob(pars)
%DPHILROB Phillips-Robinson sleep wake cycle model
%   Returns the function handle for the differential equation, ready to be 
%   integrated by ode45 or any other Matlab integrating function
%
%   Reference:
%   Phillips AJK, Robinson PA, Phillips A. 
%   A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of 
%   the Brainstem Ascending Arousal System. 
%   J Biol Rhythms. 2007 ;22(2):167–79. 
%   Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512

% Auxiliary functions
S = @(V) pars.Qmax./(1 + exp((pars.theta-V)./pars.sigma));
C = @(t) 0.5*(1 + cos(pars.w.*(t - pars.alpha))); % TODO: This is an approximation

% Differential equation
% Coupling matrix
coupling = [0,          -pars.vvm,      pars.vvh;
            -pars.vmv,      0,          0;
            0,          pars.mu,        0];

% Saturated vector
satvec = @(y) [S(y(1));
               S(y(2));
               y(3)];

% Decay term
sink = @(y) [y(1);
             y(2);
             y(3)];

% Source term          
source = @(t,y) [-pars.vvc.*C(t);
                 pars.vmaSa;
                 0];
          
% Build the differential equation
dy = @(t, y) (coupling*satvec(y) + source(t,y) - sink(y))./[pars.tauv; pars.taum; pars.Xi];

end