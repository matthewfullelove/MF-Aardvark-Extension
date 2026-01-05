function dx = glider(~, x, D)
% GLIDER  Defines the RHS of the glider system (includes x and y)
% INPUTS:
%     x  - state vector [theta; s; X; Y]
%     D  - drag parameter
% OUTPUT:
%     dx - time derivates [theta'; s'; X'; Y']

theta = x(1);
s     = x(2);

dx = zeros(4,1);

dx(1) = s - cos(theta)/s;      
dx(2) = -sin(theta) - D*s^2;   
dx(3) = s*cos(theta);          
dx(4) = s*sin(theta);          
end
