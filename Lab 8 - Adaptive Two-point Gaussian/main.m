% The exact value of the integral
syms x
f(x) = (sin(10/x))/x;
a = 1;
b = 3;
exact = double(int(f,a,b)) % Exact Value

% Basic two-point Gauss procedure Gauss(f,a,b) 
approx = Gauss(f,a,b)

% Recursive function
sum = 0;
level = 0;
depth = 100;
S = Adaptive(f,sum,a,b,level,depth)


