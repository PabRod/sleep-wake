function dy = dtwocycles(varargin)
%D2CYCLES Toy model for sleep-wake cycles

%% Parse input
% Default values taken from the paper mentioned above
default = genPars('twocycles');

% Flexible parsing
p = inputParser;
p.addParameter('a', default.a);
p.addParameter('b', default.b);
p.addParameter('c', default.c);
p.addParameter('d', default.d);
p.addParameter('wf', default.wf);
p.addParameter('ws', default.ws);
p.addParameter('p', default.p);
p.addParameter('wp', default.wp);

p.parse(varargin{:});
pars = p.Results;

%% Build the dynamics
dr = @(t, r, pars) polyval([pars.a, pars.b, pars.c, pars.d], r(1,:)) + pars.p.*sin(pars.wp.*t);

% Compute the roots of dr
rts = roots([pars.a, pars.b, pars.c, pars.d]);
rf = rts(3);
%mu = rts(2);
rs = rts(1);

dtheta = @(t, r, pars) pars.wf*(pars.ws/pars.wf).^((r(1,:)-rf)/(rs - rf));

% In polar coordinates
dy_pol = @(t, r) [dr(t, r, pars);
                  dtheta(t, r, pars)];
               
% In cartesian coordinates
dy = polToCartFlow(dy_pol);

end

