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

%% Auxiliary functions
% Transforms (x, y) -> (r, theta)
radius = @(y) norm(y, 2);
theta = @(y) atan(y(2)./y(1));

% Transformation's jacobian
transform = @(y) [y(1)./radius(y),  -y(2);
                  y(2)./radius(y),  y(1)];
              
%% Build the cartesian handle
dy_cart = @(t, y) transform(y)*dy_pol(t, [radius(y); theta(y)], varargin{:});

end