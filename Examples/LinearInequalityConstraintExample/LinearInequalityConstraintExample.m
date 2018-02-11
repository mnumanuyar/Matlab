%% Linear Inequality Constraint  
% Find the minimum value of Rosenbrock's function when there is a linear
% inequality constraint.   

% Copyright 2015 The MathWorks, Inc.


%% 
% Set the objective function |fun| to be Rosenbrock's function. Rosenbrock's
% function is well-known to be difficult to minimize. It has its minimum
% objective value of 0 at the point (1,1). For more information, see <docid:optim_ug.brg0p3g-1>. 
fun = @(x)100*(x(2)-x(1)^2)^2 + (1-x(1))^2;  

%% 
% Find the minimum value starting from the point |[-1,2]|, constrained to
% have $x(1) + 2x(2) \le 1$. Express this constraint in the
% form |Ax <= b| by taking |A = [1,2]| and |b = 1|. Notice that this
% constraint means that the solution will not be at the unconstrained
% solution (1,1), because at that point $x(1) + 2x(2) = 3 > 1$.
x0 = [-1,2];
A = [1,2];
b = 1;
x = fmincon(fun,x0,A,b)   

