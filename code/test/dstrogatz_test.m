% Parameters
absTol = 1e-9;

%% Input parser default
dy = dstrogatz();

dy_example = dy(0, [1;2]);
d = size(dy_example);
assert(d(1) == 2);
assert(d(2) == 1);

%% Input parser non-default
dy = dstrogatz('w1', 1.1);

dy_example = dy(0, [1;2]);
d = size(dy_example);
assert(d(1) == 2);
assert(d(2) == 1);

%% Equilibrium
pars = genPars('strogatz1987');
dy = dstrogatz(pars);

% The equilibrium (for the difference) can be analytically computed
omega = pars.w2 - pars.w1;
C = pars.C1 + pars.C2;
psi_eq = 1/(2*pi)*acos(omega/C);

% Evaluating the derivative at the equilibrium (for the difference) ...
dy_eq = dy(0, [psi_eq; 0]);
expected_dy_eq = [pars.w1 - pars.C1*omega/C; ... % we expect to find this ...
                  pars.w2 + pars.C2*omega/C]; % ... "compromise" frequencies
              
for i = 1:2
   assert(abs(dy_eq(i) - expected_dy_eq(i)) < absTol); 
end