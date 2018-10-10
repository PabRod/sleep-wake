function pars = genPars(id)
%GENPARS Generates the parameters as stated in different papers
%
%   Example:
%
%   pars = genPars('philrob2007');
%
%   Papers and identifiers:
%
%   'philrob2007':
%   Phillips AJK, Robinson PA, Phillips A.
%   A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of
%   the Brainstem Ascending Arousal System.
%   J Biol Rhythms. 2007 ;22(2):167–79.
%   Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512
%
%   'philrob2008':
%   Phillips AJK, Robinson PA.
%   Sleep deprivation in a quantitative physiologically based model of the
%   ascending arousal system.
%   J Theor Biol [Internet]. 2008 Dec 21; 255(4):413–23.
%   Available from: https://www.sciencedirect.com/science/article/pii/S002251930800444X?via%3Dihub
%
%   'philczeis2011':
%   Phillips AJK, Czeisler CA, Klerman EB.
%   Revisiting Spontaneous Internal Desynchrony Using a Quantitative
%   Model of Sleep Physiology.
%   J Biol Rhythms [Internet]. 2011 Oct 15;26(5):441–53.
%   Available from: http://www.ncbi.nlm.nih.gov/pubmed/21921298

switch id
    case 'philrob2007'
        % Source:
        %
        % Phillips AJK, Robinson PA, Phillips A.
        % A Quantitative Model of Sleep-Wake Dynamics Based on the Physiology of
        % the Brainstem Ascending Arousal System.
        % J Biol Rhythms. 2007 ;22(2):167–79.
        % Available from: http://journals.sagepub.com/doi/10.1177/0748730406297512
        
        pars.Qmax = 100*3600; % h^-1
        pars.theta = 10; % mV
        pars.sigma = 3; % mV
        
        pars.vmaSa = 1; % mV
        pars.vvm = 1.9/3600; % mV h (negative effect)
        pars.vmv = 1.9/3600; % mV h (negative effect)
        pars.vvc = 6.3; % mV (negative effect)
        pars.vvh = 0.19; % mV nM^-1
        
        pars.Xi = 10.8; % h
        pars.mu = 1e-3; % nM h
        
        pars.taum = 10/3600; % h
        pars.tauv = 10/3600; % h
        
        T = 24; % h
        pars.w = 2*pi/T; % h^-1
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
        
        pars.Qmax = 100*3600; % h^-1
        pars.theta = 10; % mV
        pars.sigma = 3; % mV
        
        pars.vmaSa = 1.3; % mV
        pars.vvm = 2.1/3600; % mV h (negative effect)
        pars.vmv = 1.8/3600; % mV h (negative effect)
        pars.vvc = 2.9; % mV (negative effect)
        pars.vvh = 1.0; % mV nM^-1
        
        pars.Xi = 45; % h
        pars.mu = 4.4/3600; % nM h
        
        pars.taum = 10/3600; % h
        pars.tauv = 10/3600; % h
        
        T = 24; % h
        pars.w = 2*pi/T; % h^-1
        pars.D = 0.6; % mV
        pars.Da = 3.4; % mV
        pars.alpha = 0.0; % rad
        
    case 'philczeis2011'
        % Source:
        %
        % Phillips AJK, Czeisler CA, Klerman EB.
        % Revisiting Spontaneous Internal Desynchrony Using a Quantitative
        % Model of Sleep Physiology.
        % J Biol Rhythms [Internet]. 2011 Oct 15;26(5):441–53. 
        % Available from: http://www.ncbi.nlm.nih.gov/pubmed/21921298
        
        pars.Qmax = 100*3600; % h^-1
        pars.theta = 10; % mV
        pars.sigma = 3; % mV
        
        pars.vmaSa = 1.3; % mV
        pars.vvm = 2.1/3600; % mV h (negative effect)
        pars.vmv = 1.8/3600; % mV h (negative effect)
        pars.vvc = 5.8; % mV (negative effect)
        pars.vvh = 1.0; % mV nM^-1
        
        pars.Xi = 50; % h
        pars.mu = 4.4/3600; % nM h
        
        pars.taum = 10/3600; % h
        pars.tauv = 10/3600; % h
        
        T = 24; % h
        pars.w = 2*pi/T; % h^-1
        pars.D = 0.6; % mV
        pars.Da = 3.4; % mV
        pars.alpha = 0.0; % rad
        
        pars.alpha0 = 0.1; % 1
        pars.I0 = 9500; % lux
        pars.I1 = 100; % lux
        pars.beta = 0.007; % 1
        pars.b = 0.4; % 1
        pars.G = 37; % 1
        pars.lambda = 60; % h^-1
        pars.gamma = 0.13; % 1
        pars.tauc = 24.1; % h
        pars.f = 0.99729; % 1
        pars.k = 0.55; % 1;
        pars.p = 10; % 1
        pars.rho = 0.032; % 1
        
        pars.kappa = 12/pi; %h
        pars.Qmth = 3600; % h^-1
        
    case 'twocycles'
        % Radial component
        pars.a = -1;
        pars.b = 6;
        pars.c = -11;
        pars.d = 6;
        
        % Angular component
        pars.wf = 2*pi/24; %h^-1
        pars.ws = 2*pi/50; %h^-1
        
        % Bifurcation parameter
        pars.p = 0;
        pars.wp = 2*pi/5000; %h^-1
        
    otherwise
        error('Wrong input');
end

end