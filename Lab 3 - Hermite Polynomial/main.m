%X = [1.3,1.6,1.9];
%Y = [0.6200860,0.4554022, 0.2818186];
%YP = [-0.5220232, -0.5698959, -0.5811571];

X = [1,2,3];
Y = [1.105170918, 1.491824698, 2.459603111];
YP = [0.2210341836, 0.5967298792, 1.475761867];

% STEP 1
[Q,z] = hermite(X,Y,YP)
n = length(X);

% STEP 2
for i = 2:2*n-1
    for j = 2:i
        Q(i+1,j+1) = (Q(i+1,j)-Q(i,j))/(z(i+1)-z(i-j+1));
    end
end
Q 

% STEP 3
x = 1.25;
sum = Y(1);
eval = [];
for i = 1:2*n-1
    prod = 1;
    for j = 1:i
        prod = prod * (x-z(j));
    end    
sum = sum + Q(i+1,i+1)*prod;
eval = [eval,sum];
end

% Question 2
H_3 = eval(3) % Using point x0,x1
H_5 = eval(5) % Using point x0,x1,x2

% Question 3
estimate_of_error_3 = H_3 - eval(2)
estimate_of_error_5 = H_5 - eval(4)

% To find error bound for H_3
syms f(y) % set up function for derivative 
f(y) = exp(0.1*y^2);
df = diff(f,y,4); % 4th derivative 
M_3 = double(df(3)); % derivative evaluated at 3

D_3 = abs((x-X(1))^2*(x-X(2))^2); % square difference b/t x and xi
fac_3 = 1/factorial(4); % factorial 

error_bound_3 = M_3*fac_3*D_3 % interpolation error formula

% To find error bound for H_5
syms f(y)
f(y) = exp(0.1*y^2);
df = diff(f,y,6);
M_5 = double(df(3));

D_5 = abs((x-X(1))^2*(x-X(2))^2*(x-X(3))^2);
fac_5 = 1/factorial(6);

error_bound_5 = M_5*fac_5*D_5



