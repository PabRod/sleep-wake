function dy_cart = polToCartFlow(dy_pol, varargin)
%POLTOCARTFLOW Transforms a flow in polar coordinates into its equivalent
%in cartesian coordinates
%
%   Example:
%
%   dy_pol = @(t, r) [r(1) + r(1).^3 - r(1).^5;
%                     1 + r(1).^2];
%
%   dy_cart = polToCartFlow(dy_pol);
%
%   Rationale:
%
%   Using the chain rule for differentiation on the (r, theta) -> (x, y)
%   transformation:
%   x = r*cos(theta) => x' = cos(theta)*r'-r*sin(theta)*theta'
%   y = r*sin(theta) => y' = sin(theta)*r'+r*cos(theta)*theta'
%
%   Equivalently, in matrix form:
%   [x'; 
%    y'] 
%    = 
%   [cos(theta), -r*sin(theta);
%   [sin(theta), r*cos(theta)]
%   *
%   [r'(r, theta);
%    theta'(r, theta)];
%
%   Lastly, rewriting everything as a function of (x, y):
%
%   [x'; 
%    y'] 
%    = 
%   [x/sqrt(x^2+y^2), -y;
%   [y/sqrt(x^2+y^2), x]
%   *
%   [r'(sqrt(x^2 + y^2), atan(y/x));
%    theta'(sqrt(x^2 + y^2), atan(y/x))];
%
%   Pablo Rodr�guez-S�nchez
%   pabrod.github.io	

%% Auxiliary functions
% Transforms (x, y) -> (r, theta)
radius = @(y) norm(y, 2);
theta = @(y) atan2(y(2), y(1));

% Transformation's jacobian
transform = @(y) [y(1)./radius(y),  -y(2);
                  y(2)./radius(y),  y(1)];
              
%% Build the cartesian handle
dy_cart = @(t, y) transform(y)*dy_pol(t, [radius(y); theta(y)], varargin{:});

end