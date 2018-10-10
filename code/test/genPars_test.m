%% Read
pars = genPars('philrob2007');

assert(isstruct(pars));
assert(pars.Qmax == 100*3600);

%% Override
pars = genPars('philrob2008');
pars.Qmax = 150;

assert(pars.Qmax == 150);