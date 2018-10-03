function pars = genPars(id)
%GENPARS Generates the parameters as stated in different papers
%   Example:
%   pars = genPars('philrob2007');

switch id
    case 'philrob2007'
        % Source:
        %
        % Phillips AJK, Robinson PA, Phillips A.
        % A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of
        % the Brainstem Ascending Arousal System.
        % J Biol Rhythms. 2007 ;22(2):167–79.
        % Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512
        
        pars.Qmax = 100; % s^-1
        pars.theta = 10; % mV
        pars.sigma = 3; % mV
        
        pars.vmaSa = 1; % mV
        pars.vvm = 1.9; % mV s (negative effect)
        pars.vmv = 1.9; % mV s (negative effect)
        pars.vvc = 6.3; % mV (negative effect)
        pars.vvh = 0.19; % mV nM^-1
        
        pars.Xi = 10.8 * 3600; % s
        pars.mu = 1e-3 * 3600; % nM s
        
        pars.taum = 10; % s
        pars.tauv = 10; % s
        
        T = 3600*24; % s
        pars.w = 2*pi/T; % s^-1
        pars.D = 0.77; % mV
        pars.Da = 0.42; % mV
        pars.alpha = 0.0; % rad
        
    case 'philrob2008'
        % Source:
        %
        % Phillips AJK, Robinson PA.
        % Sleep deprivation in a quantitative physiologically based model of the
        % ascending arousal system.
        % J Theor Biol [Internet]. 2008 Dec 21; 255(4):413–23.
        % Available from: https://www.sciencedirect.com/science/article/pii/S002251930800444X?via%3Dihub
        
        pars.Qmax = 100; % s^-1
        pars.theta = 10; % mV
        pars.sigma = 3; % mV
        
        pars.vmaSa = 1.3; % mV
        pars.vvm = 2.1; % mV s (negative effect)
        pars.vmv = 1.8; % mV s (negative effect)
        pars.vvc = 2.9; % mV (negative effect)
        pars.vvh = 1.0; % mV nM^-1
        
        pars.Xi = 45 * 3600; % s
        pars.mu = 4.4; % nM s
        
        pars.taum = 10; % s
        pars.tauv = 10; % s
        
        T = 3600*24; % s
        pars.w = 2*pi/T; % s^-1
        pars.D = 0.6; % mV
        pars.Da = 3.4; % mV
        pars.alpha = 0.0; % rad
end

end

