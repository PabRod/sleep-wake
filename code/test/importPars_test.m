%% Default
pars = importPars('philrob.csv');

assert(isstruct(pars));
assert(pars.Qmax == 100);

%% Non default
pars_1 = importPars('philrob.csv', 'philrob2008');
pars_2 = importPars('philrob.csv', 2);

assert(isstruct(pars_1));
assert(isstruct(pars_2));
assert(pars_1.Xi == pars_2.Xi);